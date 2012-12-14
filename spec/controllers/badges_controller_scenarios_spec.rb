require 'spec_helper'

describe "BadgesController Scenarios" do
  let(:badge_set) { FactoryGirl.create :badge_set_with_badges, badges_count: 10 }
  let(:badges) { badge_set.badges }
  let(:badge) { badges.first }
  
  context "when visit badges page" do
    before { visit "/archive/#{badge_set.to_param}/badges" }
    subject { page }
    
    it { should have_css ".btn-primary", count: 1, text: I18n.t('views.badges.links.add_member') }
    it { should have_css ".table", count: 1 }
    it { should have_css ".pagination", count: 1 }

    # Table
    it do
      within('.table') do
        should have_css 'tbody tr', count: 5
        should have_css 'td', text: badges.first.name
        should have_css 'td', text: badges.first.surname
        should have_css 'td', text: badges.first.company
        should have_css 'td', text: badges.first.profession
        
        should have_css 'td', text: badges.fifth.name
        should_not have_css 'td', text: badges[6].name
      end
    end

    # Pagination    
    it do
      within('.pagination') do
        should have_css 'li', count: 4
        should have_css 'li.active', count: 1, text: "1"
        
        should have_css 'li', text: "1"
        should have_css 'li', text: "2"
      end
    end
    
    # Action links
    it do
      within("tbody tr:first-child") do
        should have_css ".btn-group", count: 1
        
        within(".btn-group") do
          should have_css ".dropdown-menu", count: 1
          should have_css ".btn", count: 2
          should have_css ".btn", text: I18n.t('forms.labels.see')
          
          within(".dropdown-menu") do
            should have_css "li", count: 2
            should have_css "li", text: I18n.t('forms.labels.edit')
            should have_css "li", text: I18n.t('forms.labels.delete')
          end
        end
      end
    end
  end
  
  context "when edit badge" do
    before { visit "/archive/#{badge_set.to_param}/badges/#{badge.to_param}/edit" }

    subject { page }
    
    it_behaves_like "object form" do
      let(:object) { badge }
    end
    
    context "when click submit with wrong fields" do
      before { page.fill_in "badge[name]", with: nil }
      before { page.click_button I18n.t("forms.labels.save") }
      
      it_behaves_like "error notice"
    end
    
    context "when click submit with correct fields" do
      before { page.click_button I18n.t("forms.labels.save") }
      
      it_behaves_like "success notice"
    end
  end
  
  context "when create badge" do
    before { visit "/archive/#{badge_set.to_param}/badges/new" }

    subject { page }
    let(:badge) { badge_set.badges.build }

    it_behaves_like "object form" do
      let(:object) { badge }
    end
    
    context "when click submit with wrong fields" do
      before { page.fill_in "badge[name]", with: nil }
      before { page.click_button I18n.t("forms.labels.save") }
      
      it_behaves_like "error notice"
    end
    
    context "when click submit with correct fields" do
      before { page.fill_in "badge[name]", with: "Jonny" }
      before { page.fill_in "badge[company]", with: "PirateBay" }
      before { page.click_button I18n.t("forms.labels.save") }
      
      it_behaves_like "success notice"
    end
  end
  
  context "when delete badge" do
    before { visit "/archive/#{badge_set.to_param}/badges" }
    subject { page }
    
    let(:badge_row) { page.find("tbody tr:first-child") }
    
    context "when delete badge" do
      before { badge_row.click_link(I18n.t "forms.labels.delete") }
            
      it_behaves_like "success notice"
      it { badge_row.dup.reload.should_not eq badge_row }
    end
  end
  
  context 'when show badge' do
    before { visit "/archive/#{badge_set.to_param}/badges/#{badge.to_param}" }
    subject { page }
    
    it { should have_css ".badge-k-2h", count: 1 }
    
    # Badge
    it do
      within(".badge-k-2h") do
        should have_css ".information", count: 1
        should have_css ".personality", count: 1
      end
    end
    
    # Information
    it do
      within(".badge-k-2h .information") do
        should have_css "h3", count: 1
        
        within("h3") do
          should have_content badge.company
          should have_content badge.profession
        end
      end
    end
    
    # Personality
    it do
      within(".badge-k-2h .personality") do
        should have_css "h1", count: 2
        should have_css "h1", text: badge.name
        should have_css "h1", text: badge.surname
      end
    end
    
    # No Pictute
    context "when set dont have image" do
      it { within(".badge-k-2h") { should_not have_css ".picture", count: 1 } }
    end
    
    # Picture
    context "when set have image" do
      let(:badge_set) { FactoryGirl.create :badge_set_with_badges, :image }

      it do
        within(".badge-k-2h") do
          should have_css ".picture", count: 1
          should have_css ".picture > img", count: 1
        end
      end
    end
  end
end