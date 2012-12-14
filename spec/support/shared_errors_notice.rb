# -> subject { page }
shared_examples "error notice" do
  it { should have_css ".alert-danger", count: 1 }
  
  # Notice
  it do
    within(".alert-danger") do
      should have_css "h4", count: 1
      should have_css "ol", count: 1
      should have_css "ol > li", minimum: 1
    end
  end
end