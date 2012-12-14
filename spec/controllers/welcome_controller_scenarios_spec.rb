require 'spec_helper'

describe "WelcomeController Scenarios" do
  before { visit "/" }
  subject { page }

  it { should have_css ".btn-primary", text: I18n.t("jumbotron.button"), count: 1 }
  it { should have_css ".nav.nav-pills", count: 1 }

  context "when click on big button" do
    before { page.click_link I18n.t("jumbotron.button") }

    it_behaves_like "object upload form" do
      let(:object) { BadgeSet.new }
    end
  end
end