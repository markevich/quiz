module ApplicationHelper
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
