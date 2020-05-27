defmodule Servy.Handler do

    import Servy.Plugins, only: [ rewrite_path: 1, log: 1, track: 1]
    import Servy.Parser, only: [ parse: 1]
    import Servy.FileHandler, only: [ handle_file: 2 ]

    alias Servy.Conv
    alias Servy.BearsController
    @moduledoc """
    Handles HTTP request
    """

    @moduledoc """
    transforms the request into a response
    """
    def handler(request) do
        # conv = parse(request)
        # conv = route(conv)
        # format_response(conv)
        request
        |>parse
        |>rewrite_path
        |> log
        |> route
        |> track
        |> format_response
    end

    # def route(conv) do
    #     #TODO: create a new map that also has the response body
    # #    %{conv | res_body: "Bears, Lions, Tigers"}
    #     route(conv, conv.method, conv.path)
    # end

    def route(%Conv{ method: "GET", path: "/wildthings" } = conv) do
        %{conv | status: 200, res_body: "Bears, Lions, Tigers"}
    end

    @pages_path Path.expand("pages", File.cwd!)

    def route(%Conv{ method: "GET", path: "/about" } = conv) do
        @pages_path
        |> Path.join("about.html")
        |> File.read
        |> handle_file(conv)
        # case File.read(file)  do
        #     {:ok, content} ->
        #         %{ conv | status: 200, res_body: content}
        #     {:error, :enoent } -> 
        #         %{ conv | status: 404, res_body: "FIle not found"}
        #     {:error, reason } -> 
        #         %{ conv | status: 404, res_body: "FIle error: #{reason}!"}
        # end
    end


    def route(%Conv{ method: "GET", path: "/bears" } = conv) do
        BearsController.index(conv)
    end

    #name=Johndoe&type=Brown
    def route(%Conv{ method: "POST", path: "/bears" } = conv) do
        BearsController.create(conv, conv.params)
    end

    def route(%Conv{ method: "GET", path: "/bears/new" } = conv) do
        @pages_path
        |> Path.join("form.html")
        |> File.read
        |> handle_file(conv)
    end

    def route(%Conv{ method: "GET", path: "/pages/"<> file } = conv) do
        @pages_path
        |> Path.join(file<>".html")
        |> File.read
        |> handle_file(conv)
    end


    def route(%Conv{ method: "GET", path: "/bears/" <> id } = conv) do
        params = Map.put(conv.params, "id", id)
        BearsController.show(conv, params)
    end

    def route(%Conv{path: path} = conv) do
        %{conv | status: 404, res_body: "no #{path} route"}
    end
    def format_response(%Conv{} = conv) do
        #TODO: use valyes in the map to create an HTTP response string
        """
        HTTP/1.1 Conv.full_status(conv)
        Content-Type: text/html
        Content-Length: #{String.length(conv.res_body)}

        #{conv.res_body}
        """
    end

end



# request = """
# GET /wildthings HTTP/1.1
# Host: example.com
# User-Agent: ExampleBrowser/1.0
# Accept: */*
# """

# response = Servy.Handler.handler(request)
# IO.puts response

# request = """
# GET /wildlife HTTP/1.1
# Host: example.com
# User-Agent: ExampleBrowser/1.0
# Accept: */*
# """

# response = Servy.Handler.handler(request)
# IO.puts response

request = """
GET /bears HTTP/1.1
Host: example.com
User-Agent: ExampleBrowser/1.0
Accept: */*


"""

response = Servy.Handler.handler(request)
IO.puts response

# request = """
# GET /bears/new HTTP/1.1
# Host: example.com
# User-Agent: ExampleBrowser/1.0
# Accept: */*
# """

# response = Servy.Handler.handler(request)
# IO.puts response

# response = Servy.Handler.handler(request)
# IO.puts response

# request = """
# GET /bears/2 HTTP/1.1
# Host: example.com
# User-Agent: ExampleBrowser/1.0
# Accept: */*
# """

# response = Servy.Handler.handler(request)
# IO.puts response

# request = """
# GET /bears?id=3 HTTP/1.1
# Host: example.com
# User-Agent: ExampleBrowser/1.0
# Accept: */*
# """

# response = Servy.Handler.handler(request)
# IO.puts response

# request = """
# GET /about HTTP/1.1
# Host: example.com
# User-Agent: ExampleBrowser/1.0
# Accept: */*
# """

# response = Servy.Handler.handler(request)
# IO.puts response



# request = """
# GET /bigfoot HTTP/1.1
# Host: example.com
# User-Agent: ExampleBrowser/1.0
# Accept: */*
# """

# response = Servy.Handler.handler(request)
# IO.puts response

# request = """
# GET /pages/faq HTTP/1.1
# Host: example.com
# User-Agent: ExampleBrowser/1.0
# Accept: */*
# """

# response = Servy.Handler.handler(request)
# IO.puts response

# request = """
# POST /bears HTTP/1.1
# Host: example.com
# User-Agent: ExampleBrowser/1.0
# Accept: */*
# Content-Type: application/x-www-form-urlencoded
# Content-Length: 21

# name=John philip&type=Purple
# """

# response = Servy.Handler.handler(request)
# IO.puts response

