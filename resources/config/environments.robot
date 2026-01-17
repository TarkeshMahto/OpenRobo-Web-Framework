*** Settings ***
Documentation    Environment-specific configurations
Library          Collections
Library          OperatingSystem


*** Variables ***
# Environment selection - can be overridden via command line
${ENVIRONMENT}                        dev

# Development environment
${DEV_BASE_URL}                       https://www.amazon.com
${DEV_TIMEOUT}                        30s
${DEV_HEADLESS}                       False

# Staging environment
${STAGING_BASE_URL}                   https://staging.amazon.com
${STAGING_TIMEOUT}                    30s
${STAGING_HEADLESS}                   True

# Production environment
${PROD_BASE_URL}                      https://www.amazon.com
${PROD_TIMEOUT}                       30s
${PROD_HEADLESS}                      True
