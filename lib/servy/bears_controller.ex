defmodule Servy.BearsController do
	
	alias Servy.Wildthings
	def index(conv) do
		%{conv | status: 200, res_body: "Teddy, Cougaur, Benx"}
	end

	def show(conv, %{"id" => id}) do
		%{conv | status: 200, res_body: "Bear #{id}"}
	end

	def create(conv, %{ "name" => name, "type" => type}) do

        %{conv | status: 201, res_body: "created a #{type} bear named #{name}"}
	end
end