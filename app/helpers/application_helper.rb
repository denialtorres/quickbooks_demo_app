module ApplicationHelper
  def connected?(qbo_account)
    if qbo_account.access_token.present?
      content_tag(:i, "", class: "fa fa-check-circle fa-3x text-success")
    else
      link_to "Connect to Quickbooks", @redirect_uri,
              role: "button",
              id: "connect-button",
              class: "connect-to-quickbooks-btn",
              style: "background-color: #2ca01c; color: white; padding: 14px 28px; border-radius: 6px; text-decoration: none; display: inline-block; font-weight: 600; font-size: 16px; border: none; cursor: pointer; box-shadow: 0 2px 4px rgba(0,0,0,0.1); transition: all 0.3s ease; font-family: 'Poppins', Arial, sans-serif;",
              onmouseover: "this.style.backgroundColor='#248516'; this.style.boxShadow='0 4px 8px rgba(0,0,0,0.2)';",
              onmouseout: "this.style.backgroundColor='#2ca01c'; this.style.boxShadow='0 2px 4px rgba(0,0,0,0.1)';"
    end
  end

  def disconnect_link(account)
    title = "disconnect from Quickbooks"
    alert = "Are you sure you want to #{title}?"
    content = font_icon("plug", add: "fa-3x text-danger disconnect", title: title)
    link_to content, disconnect_accounts_path(account), data: { confirm: alert }
  end

  # Font Awesome icon helper
  # Usage examples:
  #   font_icon("flag")                                    # => <i class="fa-solid fa-flag"></i>
  #   font_icon("amazon", style: "brands")                # => <i class="fa-brands fa-amazon"></i>
  #   font_icon("bell", style: "regular")                  # => <i class="fa-regular fa-bell"></i>
  #   font_icon("plug", add: "fa-3x text-danger")          # => <i class="fa-solid fa-plug fa-3x text-danger"></i>
  #   font_icon("user", title: "User icon")                # => <i class="fa-solid fa-user" title="User icon"></i>
  def font_icon(name, style: "solid", add: nil, **options)
    classes = [ "fa-#{style}", "fa-#{name}" ]
    classes << add if add.present?

    content_tag(:i, "", class: classes.compact.join(" "), **options)
  end
end
