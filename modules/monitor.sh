#!/usr/bin/env bash
echo "Basic monitor snapshot:"
echo "Uptime:"; uptime
echo "Disk usage:"; df -h / | sed -n '1,2p'
echo "Memory:"; free -h
echo "Top processes:"; ps aux --sort=-%mem | head -n 10
