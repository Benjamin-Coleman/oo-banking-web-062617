class Transfer
  
  attr_accessor :status, :amount
  attr_reader :sender, :receiver

  def initialize(sender, receiver, amount)
  	@sender = sender
  	@receiver = receiver
  	@amount = amount
  	@status = "pending"
  end

  def valid?
  	(sender.valid? && receiver.valid?)
  end

  def execute_transaction
  	@sender.balance -= @amount
  	@receiver.balance += @amount
  	if valid? && @status == "pending"
  		@status = "complete"
  		return "Transfer successful"
  	else
  		@status = "rejected"
  		reverse_transfer
  		@status = "rejected"
  		"Transaction rejected. Please check your account balance."
  	end  	

  end

	def reverse_transfer
		if @status == "complete" || @status == "rejected"
			@sender.balance += @amount
	  		@receiver.balance -= @amount
	  		@status = "reversed"
	  	else
	  		return
	  	end
	end


end
