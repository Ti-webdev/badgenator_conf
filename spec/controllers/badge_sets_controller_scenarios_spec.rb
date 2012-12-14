require 'spec_helper'

describe "BadgeSetsController Scenarios" do
  context "when visit badge_sets page" do
    let!(:badge_sets) { FactoryGirl.create_list :badge_set, 22, :image }

    before { visit "/archive" }
    subject { page }
    
    it { should have_css ".btn-primary", count: 1, text: I18n.t('views.badge_sets.links.add_set') }
    it { should have_css ".table", count: 1 }
    it { should have_css ".pagination", count: 1 }

    # Table
    it do
      within('.table') do
        should have_css 'tbody tr', count: 20
        should have_css "td > img[src='#{badge_sets.first.image.thumb.url}']"
        should have_css 'td', text: badge_sets.first.name
        
        should have_css 'td', text: badge_sets[19].name
        should_not have_css 'td', text: badge_sets[20].name
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
            should have_css "li", count: 3
            should have_css "li", text: I18n.t('forms.labels.print')
            should have_css "li", text: I18n.t('forms.labels.edit')
            should have_css "li", text: I18n.t('forms.labels.delete')
          end
        end
      end
    end
  end
  
  context "when edit badge_set" do
    let(:badge_set) { FactoryGirl.create :badge_set, :image }

    before { visit "/archive/#{badge_set.to_param}/edit" }
    subject { page }

    it_behaves_like "object upload form" do
      let(:object) { badge_set }
    end
    
    context "when click submit with wrong fields" do
      before { page.fill_in "badge_set[name]", with: nil }
      before { page.click_button I18n.t("forms.labels.save") }
    
      it_behaves_like "error notice"
    end
    
    context "when click submit with correct fields" do
      before { page.click_button I18n.t("forms.labels.save") }

      it_behaves_like "success notice"
    end
  end
  
  context "when create badge_set" do
    let(:badge_set) { BadgeSet.new }

    before { visit "/archive/new" }
    subject { page }

    it_behaves_like "object upload form" do
      let(:object) { badge_set }
    end
    
    context "when click submit with wrong fields" do
      before { page.fill_in "badge_set[name]", with: nil }
      before { page.click_button I18n.t("forms.labels.save") }
      
      it_behaves_like "error notice"
    end
    
    context "when click submit with correct fields" do
      before { page.fill_in "badge_set[name]", with: "Lucias Set" }
      before { page.click_button I18n.t("forms.labels.save") }
      
      it_behaves_like "success notice"
    end
  end
  
  context "when delete badge_set" do
    let!(:badge_sets) { FactoryGirl.create_list :badge_set, 5, :image }
    let(:badge_set_row) { page.find("tbody tr:first-child") }

    before { visit "/archive" }
    subject { page }
    
    context "when delete set" do
      before { badge_set_row.click_link(I18n.t "forms.labels.delete") }
            
      it_behaves_like "success notice"
      it { badge_set_row.dup.reload.should_not eq badge_set_row }
    end
  end
  
  context 'when print badge_set' do
    let(:badge_set) { FactoryGirl.create :badge_set_with_badges }
    let(:badge) { badge_set.badges.first }

    before { visit "/archive/#{badge_set.to_param}/print" }
    subject { page }
    
    it { should have_css ".badge-k-2h", count: badge_set.badges.count }
    
    # Badge
    it do
      within(".badge-k-2h:first-child") do
        should have_css ".information", count: 1
        should have_css ".personality", count: 1
      end
    end
    
    # Information
    it do
      within(".badge-k-2h:first-child .information") do
        should have_css "h3", count: 1
        
        within("h3") do
          should have_content badge.company
          should have_content badge.profession
        end
      end
    end
    
    # Personality
    it do
      within(".badge-k-2h:first-child .personality") do
        should have_css "h1", count: 2
        should have_css "h1", text: badge.name
        should have_css "h1", text: badge.surname
      end
    end

    # Picture
    it do
      within(".badge-k-2h:first-child") do
        should_not have_css ".picture"
      end
    end
    
    context "when badge_set have picture" do
      let(:badge_set) { FactoryGirl.create :badge_set_with_badges, :image }

      # Picture
      it do
        within(".badge-k-2h:first-child") do
          should have_css ".picture", count: 1
          should have_css ".picture > img", count: 1
        end
      end
    end
  end
end