require "rails_helper"

describe Importer::Efolio do

  let(:klass) { Importer::Efolio }

  describe "import" do

    it "test file" do
      file = Rails.root.join("spec/support/efolio_sample.csv")

      allow(Importer::Efolio).to receive(:cleanup)

      Importer::Efolio.import(file)
    end
  end

  it ".table_name" do
    expect(klass.table_name).to eq("notes")
  end

  it ".fields_to_sql" do
    fields = ["id", "loan_id"]
    expect(klass.fields_to_sql(fields)).to eq("id, loan_id")
  end

end
