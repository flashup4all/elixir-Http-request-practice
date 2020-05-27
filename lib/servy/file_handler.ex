defmodule Servy.FileHandler do

	@moduledoc """
	handles file

	"""
	def handle_file({:ok, content}, conv) do
        %{ conv | status: 200, res_body: content }
    end

    def handle_file({:error, :enoent}, conv) do
        %{ conv | status: 404, res_body: "FIle not found"}
    end
    def handle_file({:error, reason}, conv) do
        %{ conv | status: 404, res_body: "FIle error: #{reason}!"}
    end
end