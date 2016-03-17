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

    it "should create 9 records in each table" do
      file = Rails.root.join("spec/support/efolio_sample.csv")

      allow(Importer::Efolio).to receive(:remove_intactive_notes)
      allow(Importer::Efolio).to receive(:cleanup)

      Importer::Efolio.import(file)

      expect(Note.count).to eq(9)
      expect(NoteTs.count).to eq(9)
    end
  end

  #
  # helper methods
  #

  describe "remove_intactive_notes" do
    it 'base case' do
      Note.create(note_id: 1)
      Note.create(note_id: 2)
      Note.create(note_id: 3)

      file = Rails.root.join("spec/support/efolio_sample.csv")
      Importer::Efolio.remove_intactive_notes(file)
    end
  end

  it ".table_name_note" do
    expect(klass.table_name_note).to eq("notes")
  end

  it ".table_name_note" do
    expect(klass.table_name_note_ts).to eq("notes_ts")
  end

  it ".fields_to_sql" do
    fields = ["id", "loan_id"]
    expect(klass.fields_to_sql(fields)).to eq("id, loan_id")
  end

end
