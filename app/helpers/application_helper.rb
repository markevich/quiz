module ApplicationHelper
  def title text
    content_for :title do
      text
    end
  end
  def flash_messages
    types = [:notice, :warning, :messag]
    messages = []
    types.each {|type| messages << flash[type] if flash[type]}
    render(
      :partial => 'layouts/flash_messages',
      :locals => {:messages => messages}
    )  unless messages.blank?

  end
end
