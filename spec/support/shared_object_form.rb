# -> subject { page }
shared_examples "object form" do
  # -> let(:object) { ActiveRecord object }
    
  let(:tag) { object.class.name.underscore }
    
  def object_attribute(attribute)
    object.new_record? ? "##{tag}_#{attribute}"
                      : "##{tag}_#{attribute}[value='#{object[attribute]}']"
  end
    
  it { should have_css '.form', count: 1 }

  # Form
  it do
    within(".form") do
      should have_css object_attribute(:name)
      should have_css object_attribute(:surname)
      should have_css object_attribute(:company)
      should have_css object_attribute(:profession)
      should have_css ".btn", count: 2
      should have_css ".btn-primary", count: 1
    end
  end
end
