# -> subject { page }
shared_examples "success notice" do
  it { should have_css ".alert-success", count: 1 }  
end