ExUnit.start

defmodule Gmail.LabelTest do

  use ExUnit.Case
  import Mock

  setup do

    label_id = "Label_22"
    label_name = "Cool Label"
    label = %{
      "id" => label_id,
      "name" => label_name
    }
    expected_result = %Gmail.Label{
      id: label_id,
      name: label_name
    }
    {:ok, %{
        label_id: label_id,
        label: label,
        expected_result: expected_result
      }}
  end

  # test "creates a new label" do
  # end

  # test "deletes a label" do

  # end

  # test "lists all labels" do

  # end

  # test "updates a label" do

  # end

  test "gets a label", context do
    with_mock Gmail.HTTP, [ get: fn _at, _url -> { :ok, context[:label] } end] do
      with_mock Gmail.OAuth2.Client, [ get_config: fn -> context[:access_token_rec] end ] do
        {:ok, label} = Gmail.Label.get(context[:label_id])
        assert context[:expected_result] == label
        assert called Gmail.OAuth2.Client.get_config
        assert called Gmail.HTTP.get(context[:access_token], Gmail.Base.base_url <> "users/me/labels/" <> context[:label_id])
      end
    end
  end

  # test "patches a label" do

  # end

end
