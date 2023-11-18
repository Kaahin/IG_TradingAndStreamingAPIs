# IG_TradingAndStreamingAPIs

MATLAB interfaces for IG's Trading and Streaming APIs, enabling automated trading, market data access, and real-time financial data streaming.

## Overview
This repository contains MATLAB scripts designed to interact with IG Group's trading and streaming APIs. These scripts are useful for traders and analysts who require automated access to financial markets data and trading operations.

## Contents
- `IG_Streaming_API.m`: Connects to IG's streaming API for real-time market data.
- `IG_Trading_API.m`: Interfaces with IG's trading API for executing trades and managing accounts.

## Getting Started
To use these scripts, ensure you have a MATLAB environment and an IG account with API access.

### Prerequisites
- MATLAB
- IG account with API access

### Installation
1. Clone the repository or download the `.m` files.
2. Open the scripts in MATLAB.
3. Configure the scripts with your IG API credentials.

## Usage
Here are basic examples of how to use these scripts:

### IG_Streaming_API.m
```matlab
% Example code on how to initialize and use the streaming API
% Initialize the streaming API connection
server = 'https://api.ig.com'; % Replace with the actual server URL
username = 'your_username';
password = 'your_password';
api_key = 'your_api_key';

% Create a streaming session
session = IG_Streaming_API(server, 'CREATE', username, password, api_key);

% Subscribe to market data (replace 'MARKET_ID' with actual market ID)
market_id = 'MARKET_ID';
IG_Streaming_API(server, 'SUBSCRIBE', session, 'MERGE', market_id, 'BID', 'OFFER');

% Example code demonstrating login and account info retrieval with IG_Trading_API.m
% Set up the trading API parameters
method = 'LOGIN';
action = 'POST';
api_key = 'your_api_key';
username = 'your_username';
password = 'your_password';

% Log in to the API
response = IG_Trading_API(method, action, api_key, username, password);

% Check account details
method = 'ACCOUNT_INFO';
account_info = IG_Trading_API(method, 'GET', api_key, response.CST_token, response.XST_token);

% Display account information
disp(account_info);

```

## License
This project is licensed under the MIT License - see the LICENSE.md file for details.

## Additional Resources
- [IG Trading API Documentation](https://labs.ig.com/rest-trading-api-reference)
- [IG Streaming API Reference](https://labs.ig.com/streaming-api-reference)

