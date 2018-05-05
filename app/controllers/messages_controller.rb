class MessagesController < ApplicationController
before_action :find_message, only: [:show, :edit, :update, :destroy]
before_action :authenticate_user!, except: [:index, :show]

	def index
		@messages = Message.all.order("created_at DESC")
		#plural because multiple messages 
		#orders recently created msg at top
	end

	def show
		#finding the message
		@message = Message.find(params[:id])	
	end

	def new
		#what kind of message is
		#@message is instant variable that can be used in views

		@message = current_user.messages.build
	end

	def create
		@message = current_user.messages.build(params.require(:message).permit(:title, :description))
	
		if @message.save
			#if message is saved correcterly
			redirect_to root_path

		else
			render 'new'
		end
	end

	def edit
		
	end

	def update
		if @message.update(message_params)
			redirect_to message_path
		else
			render 'edit'
		end
	end

	def destroy
		@message.destroy
		redirect_to root_path
	end

	private

		def message_params
			params.require(:message).permit(:title, :description)
		end

		def find_message
			@message = Message.find(params[:id])	
		end
end
