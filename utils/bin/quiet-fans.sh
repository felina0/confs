#!/usr/bin/env bash
echo "Old: $(cat /sys/firmware/acpi/platform_profile)"

echo "echo balanced | sudo tee /sys/firmware/acpi/platform_profile"
echo balanced | sudo tee /sys/firmware/acpi/platform_profile

echo "New: $(cat /sys/firmware/acpi/platform_profile)"
