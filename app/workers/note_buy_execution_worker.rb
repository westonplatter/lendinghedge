class NoteBuyExecutionWorker
  include Sidekiq::Worker

  sidekiq_options \
    :queue => :critical,
    :retry => false,
    :backtrace => true

  def perform(user_id, note_id)
    # strategy = Strategy.find(strategy_id)

    # initialize the LC client
    user = User.find(user_id)
    options = {
      access_token: user.lending_club_access_token,
      investor_id: user.lending_club_investor_id,
    }
    client = LendingClub::Client.new(options)

    # initialize the Efolio Order Collection
    note = Note.find_by(note_id: note_id)
    orders = [note.init_lc_efolio_order]

    # ensure investor id
    investor_id = user.lending_club_investor_id
    return if investor_id.nil?

    # make lending club api call
    result = client.efolio_buy(orders)

    # remove notes available notes pool
    result.each do |order|
      note = Note.find_by(note_id: order.note_id)
      note.archived!
    end
  end
end
