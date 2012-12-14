# -> subject { page }
shared_examples "object upload form" do
  # -> let(:object) { ActiveRecord object }
    
  let(:tag) { object.class.name.underscore }
    
  def object_attribute(attribute, options = {})
    empty = options.delete(:empty) || false

    (object.new_record? || empty) ? "##{tag}_#{attribute}"
                                  : "##{tag}_#{attribute}[value='#{object[attribute]}']"
  end
    
  it { should have_css '.form', count: 1 }

  # Form
  it do
    within(".form") do
      should have_css object_attribute(:name)
      should have_css object_attribute(:source, empty: true)
      should have_css object_attribute(:image, empty: true)

      unless object.new_record?
        should have_css "img[src='#{object.image.badge.url}']"
      end
      
      should have_css ".btn", count: 2
      should have_css ".btn-primary", count: 1
    end
  end
end
