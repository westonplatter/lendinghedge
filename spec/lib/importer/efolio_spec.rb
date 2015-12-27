require "rails_helper"

describe Importer::Efolio do

  it "should be true" do
    expect(true).to eq(true)
  end

  describe "import" do

    it "test file" do
      file = Rails.root.join("spec/support/efolio_sample.csv")
      Importer::Efolio.import(file)
    end
  end

end
