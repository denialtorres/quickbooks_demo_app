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
end
