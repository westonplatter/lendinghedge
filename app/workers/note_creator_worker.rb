class NoteCreatorWorker
 include Sidekiq::Worker

  def perform(attrs)
    if Note.where(loan_id: attrs["loan_id"], order_id: attrs["order_id"], note_id: attrs["note_id"]).first
      # nothing
    else
      Note.create(attrs)
    end
  end
end
