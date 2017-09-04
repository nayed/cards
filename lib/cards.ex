defmodule Cards do
  @moduledoc """
  Provides methods for creating and handling a deck of cards
  """

  @doc """
  Returns a list of strings representing a deck of playing cards
  """
  def create_deck do
    values = ~w[Ace Two Three Four Five Six Seven Eight Nine Ten]
    suits = ~w[Spades Clubs Hearts Diamonds]
    
    for suit <- suits, value <- values do
      "#{value} of #{suit}"
    end
  end

  @doc """
  Randomize a deck
  """
  def shuffle(deck) do
    Enum.shuffle deck
  end
  
  @doc """
  Determines wheter a deck contains a given card

  ## Examples
      iex> deck = Cards.create_deck
      iex> Cards.contains? deck, "Ace of Spades"
      true
  """
  def contains?(deck, card) do
    Enum.member? deck, card
  end
  
  @doc """
  Divides a deck into a hand and the remainder of the deck.
  The `hand_size` argument indicates how many cards should
  be in the hand.
  
  ## Examples
      iex> deck = Cards.create_deck
      iex> {hand, _rest_of_deck} = Cards.deal(deck, 2)
      iex> hand
      ["Ace of Spades", "Two of Spades"]
  """
  def deal(deck, hand_size) do
    Enum.split deck, hand_size
  end

  @doc """
  Save a deck as a file in the disk
  """
  def save(deck, filename) do
    binary = :erlang.term_to_binary deck
    File.write filename, binary
  end

  @doc """
  Display the deck contained in the `filename` if the `filename` exists
  """
  def load(filename) do
    case File.read(filename) do
      {:ok, binary} -> :erlang.binary_to_term binary
      {:error, _} -> "The file does not exist"
    end
  end

  @doc """
  Create a hand of cards
  """
  def create_hand(hand_size) do
    Cards.create_deck
    |> Cards.shuffle
    |> Cards.deal(hand_size)
  end
end
