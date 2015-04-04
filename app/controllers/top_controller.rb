class TopController < ApplicationController

  def index
    #果たしてこのやり方でうまくいくのだろうか
    # @concerts = []
    # orch_ids = [*(1..8)]
    # orch_ids.each do |orch_id|
    #   @concerts << Concert.where(orchestra_id: orch_id, 'datetime > ?', Time.zone.now).limit(1)
    # end
  end
end
