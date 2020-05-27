defmodule Recurse do

	def loopy([head | tail]) do
		IO.puts "#head: {head} Tail: #{inspect(tail)}"
		loopy(tail)
	end
	def loopy([]), do: IO.puts "done"
	

	def triple([head | tail]) do
		[ head * 3 | triple(tail)]
	end
	def triple([]), do: []
end

IO.inspect Recurse.triple([1,2,3,4,5,6])