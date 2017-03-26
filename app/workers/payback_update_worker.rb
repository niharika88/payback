class PaybackUpdateWorker
  include Sidekiq::Worker
  sidekiq_options retry:false

  def perform(user_id)
  	user = User.find(user_id)
    payback_points = 0
  	amount_spent_till_now = 0 
  	amount_spent_till_now = user.transactions.all.collect{ |x|  x.amount_spent.to_i }.inject(0, :+)
  	
  	if amount_spent_till_now >= 100
  		 payback_points = (amount_spent_till_now /100) * 5
  		 user.payback_point.update_attributes(point: payback_points)
  	end
  end

end
