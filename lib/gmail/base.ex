defmodule Gmail.Base do

  @moduledoc """
  Base class for common functionality.
  """

  alias Gmail.{HTTP}

  @default_base_url "https://www.googleapis.com/gmail/v1/"

  @doc """
  Performs an HTTP GET request.
  """
  @spec do_get(String.t) :: {atom, map}
  def do_get(path) do
    HTTP.get(base_url <> path)
  end

  @doc """
  Performs an HTTP POST request.
  """
  @spec do_post(String.t, map) :: {atom, map}
  def do_post(path, data) do
    HTTP.post(base_url <> path, data)
  end

  @doc """
  Performs an HTTP PUT request.
  """
  @spec do_put(String.t, map) :: {atom, map}
  def do_put(path, data) do
    HTTP.put(base_url <> path, data)
  end

  @doc """
  Performs an HTTP PATCH request.
  """
  @spec do_patch(String.t, map) :: {atom, map}
  def do_patch(path, data) do
    HTTP.patch(base_url <> path, data)
  end

  @doc """
  Performs an HTTP DELETE reauest.
  """
  @spec do_delete(String.t) :: {atom, map} | nil
  def do_delete(path) do
    HTTP.delete(base_url <> path)
  end

  @doc """
  Gets the base URL for Gmail API requests
  """
  @spec base_url() :: String.t
  def base_url do
    case Application.fetch_env(:gmail, :api) do
      {:ok, %{url: url}} ->
        url
      {:ok, api_config} ->
        api_config = %{api_config | url: @default_base_url}
        base_url
      :error ->
        Application.put_env(:gmail, :api, %{url: @default_base_url})
        base_url
    end
  end

end
