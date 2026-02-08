# QuickBooks Online Integration Demo

A Rails application demonstrating seamless integration with QuickBooks Online (QBO) via OAuth2. This app provides a complete solution for connecting user accounts to their QuickBooks Online instance, managing authentication tokens, and preparing to synchronize financial data.

## Overview

This demo application showcases a production-ready QuickBooks Online integration with the following key features:

- **OAuth2 Authentication**: Secure, industry-standard OAuth2 flow for QuickBooks Online authorization
- **Token Management**: Encrypted storage and automatic refresh of access tokens and refresh tokens
- **User Account System**: Multi-tenant architecture where each user can connect to their own QuickBooks Online account
- **Seamless User Experience**: Single-page authentication flow with elegant popup handling and success notifications
- **Modern UI/UX**: Responsive interface with brand-consistent styling and smooth transitions

## Key Features

### Authentication & Security
- Devise-based user authentication system
- OAuth2 integration with QuickBooks Online API
- Encrypted storage of sensitive credentials (access tokens, refresh tokens, company IDs)
- Session-based OAuth2 state verification to prevent CSRF attacks
- Secure redirect handling with proper validation

### QuickBooks Integration
- OAuth2 callback handling with automatic token management
- Connection status display with visual indicators
- Automatic token refresh preparation
- Background job infrastructure for data synchronization (chart of accounts, customers, items)

### User Interface
- Clean, modern dashboard design
- Brand-consistent styling with Poppins and Lora fonts
- Smooth animations and transitions
- Responsive design that works on all devices
- Real-time status updates

## Tech Stack

- **Ruby**: 3.4.1
- **Rails**: 8.1.2
- **Database**: PostgreSQL (configurable)
- **Authentication**: Devise
- **Styling**: Tailwind CSS with custom brand colors
- **Encryption**: attr_encrypted gem
- **Background Jobs**: Active Job (infrastructure ready)
- **API Client**: QuickBooks Ruby gem

## Getting Started

### Prerequisites

- Ruby 3.4.1 or higher
- Rails 8.1.2 or higher
- PostgreSQL database (or your preferred database)
- QuickBooks Online Developer Account

### Installation

1. **Clone the repository**
   ```bash
   git clone <your-repo-url>
   cd quickbooks_demo_app
   ```

2. **Install dependencies**
   ```bash
   bundle install
   ```

3. **Set up the database**
   ```bash
   rails db:create
   rails db:migrate
   ```

4. **Configure QuickBooks OAuth**

   You'll need to set up a QuickBooks Online developer account and create an app:
   
   1. Visit [QuickBooks Developer Portal](https://developer.intuit.com/app/developer/qbo)
   2. Create a new app and note your Client ID and Client Secret
   3. Configure your redirect URIs (e.g., `http://localhost:3000/accounts/oauth2_callback`)
   
   Add these to your credentials:
   ```bash
   rails credentials:edit
   ```
   
   Add your QuickBooks credentials and encryption key:
   ```yaml
   quickbooks:
     client_id: "your-client-id"
     client_secret: "your-client-secret"
     redirect_uri: "http://localhost:3000/accounts/oauth2_callback"
   
   attr_encrypted_key: "your-32-byte-hex-key"
   ```
   
   Generate a new encryption key:
   ```bash
   ruby -rsecurerandom -e "puts SecureRandom.hex(32)"
   ```

5. **Environment Variables** (Optional)
   Create a `.env` file in the root directory:
   ```env
   # QuickBooks credentials (alternative to Rails credentials)
   QUICKBOOKS_CLIENT_ID=your-client-id
   QUICKBOOKS_CLIENT_SECRET=your-client-secret
   QUICKBOOKS_REDIRECT_URI=http://localhost:3000/accounts/oauth2_callback
   ```

6. **Start the server**
   ```bash
   rails server
   ```

7. **Access the application**
   Open your browser and navigate to `http://localhost:3000`

## Usage

### User Registration

1. Click "Sign Up" on the home page
2. Enter your email and password
3. Submit the registration form

### Connecting to QuickBooks Online

1. After logging in, navigate to your account dashboard
2. Click the "Connect to QuickBooks" button
3. You'll be redirected to QuickBooks Online authorization page
4. Sign in with your QuickBooks credentials and authorize the app
5. You'll be redirected back to your dashboard with a success message

### Connection Status

- **Connected**: A green checkmark icon indicates your account is successfully connected
- **Disconnected**: The "Connect to QuickBooks" button will appear when not connected

### Managing Your Account

- View your connection status
- Disconnect from QuickBooks (if needed)
- Access your account settings

## Project Structure

```
app/
├── controllers/
│   ├── concerns/
│   │   └── oauth_actions.rb      # OAuth2 callback handling
│   └── accounts_controller.rb     # Account management
├── models/
│   ├── account.rb                 # User account model
│   └── qbo_account.rb             # QuickBooks account integration
├── views/
│   └── accounts/
│       └── qbo_account.html.erb   # Connection status page
└── helpers/
    └── application_helper.rb      # Helper methods and UI components
```

## Configuration

### QuickBooks API Scopes

The app is configured to request the following OAuth2 scopes:
- `com.intuit.quickbooks.accounting` - Access to accounting data
- `com.intuit.quickbooks.payment` - Access to payment data (if needed)

### Encryption

Sensitive data is encrypted using the `attr_encrypted` gem:
- Access tokens
- Refresh tokens
- Company IDs

Make sure your encryption key is properly secured and never committed to version control.

### OAuth2 State Verification

The app generates a random state token for each OAuth2 flow and verifies it on callback to prevent CSRF attacks.

## Background Jobs

The infrastructure is set up to handle background data synchronization:

```ruby
# To enable background jobs, uncomment in oauth_actions.rb:
InitialImportJob.perform_later(current_account.id, current_user.email)
```

This will kick off jobs to pull:
- Chart of accounts
- Customers
- Items

## Troubleshooting

### OAuth2 Callback Issues

If you're having trouble with the OAuth2 callback:
- Verify your redirect URI matches exactly in your QuickBooks app settings
- Ensure your `attr_encrypted_key` is exactly 32 bytes (64 hex characters)
- Check that your Rails environment is properly configured

### Encryption Key Error

If you encounter `ArgumentError: key must be 32 bytes`:
- Generate a new key: `ruby -rsecurerandom -e "puts SecureRandom.hex(32)"`
- Update your Rails credentials or environment variable
- Restart your server

### Token Expiration

The app is designed to handle automatic token refresh. Access tokens are valid for 1 hour, and refresh tokens are refreshed every 50 minutes.

## Deployment

### Environment Variables

For production, ensure the following are set:
```env
RAILS_ENV=production
SECRET_KEY_BASE=your-secret-key-base
DATABASE_URL=your-production-database-url
QUICKBOOKS_CLIENT_ID=your-production-client-id
QUICKBOOKS_CLIENT_SECRET=your-production-client-secret
QUICKBOOKS_REDIRECT_URI=https://your-app.com/accounts/oauth2_callback
```

### Production Considerations

- Use environment variables for all sensitive credentials
- Enable SSL/TLS for production
- Configure proper CORS settings if needed
- Set up a proper job processor (Sidekiq, Resque, etc.)
- Implement proper error logging and monitoring
- Set up regular database backups

## Future Enhancements

Potential features to add:
- Real-time data synchronization with QuickBooks
- Advanced reporting and analytics
- Multi-company support per user
- Webhook integration for QuickBooks events
- Export functionality
- Advanced filtering and search

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License.

## Support

For questions or issues, please open an issue on the GitHub repository or contact the development team.

---

**Note**: This is a demo application and should not be used in production without proper security hardening and review.