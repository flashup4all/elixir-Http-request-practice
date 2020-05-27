defmodule Servy.Plugins do

    alias Servy.Conv
    def log(conv), do: IO.inspect conv

    @moduledoc """
    Logs 404 requests
    """
    def track(%{ status: 404, path: path } = conv ) do
        IO.puts "Warning: #{path} is on the loose!"
        conv
    end

    def track(%Conv{} = conv), do: conv

    def rewrite_path(%Conv{ path: "/wildlife"} = conv) do
        %{ conv | path: "/wildthings"}
    end

    def rewrite_path(%Conv{ path: "bears?id=" <> id } = conv) do
        # IO.puts "/bears/#{id}"
        %{ conv | path: "/bears/#{id}" }
        # %{ conv | path: "/wildthings"}
    end
    

    def rewrite_path(%Conv{} = conv), do: conv

end