require "rails_helper"

describe Importer::Efolio do

  let(:klass) { Importer::Efolio }

  describe "import" do

    it "test file" do
      file = Rails.root.join("spec/support/efolio_sample.csv")

      allow(Importer::Efolio).to receive(:remove_intactive_notes)
      allow(Importer::Efolio).to receive(:cleanup)

      Importer::Efolio.import(file)
    end
  end

  describe "remove_intactive_notes" do
    it 'base case' do
      Note.create(note_id: 1)
      Note.create(note_id: 2)
      Note.create(note_id: 3)

      file = Rails.root.join("spec/support/efolio_sample.csv")
      Importer::Efolio.remove_intactive_notes(file)
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
