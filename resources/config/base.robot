*** Settings ***
Documentation    Base configuration for all Robot Framework tests
Library          Browser
Library          Collections
Library          String
Library          DateTime
Library          OperatingSystem


*** Variables ***
${HEADLESS}                           False
${BROWSER_TYPE}                       chromium
${SLOWMO}                             0
${TIMEOUT}                            30s
${VIEWPORT_WIDTH}                     1280
${VIEWPORT_HEIGHT}                    720
${BASE_URL}                           https://www.amazon.com
${SCREENSHOT_DIR}                     ${EXECDIR}/results/screenshots
${VIDEO_DIR}                          ${EXECDIR}/results/videos
${TRACE_DIR}                          ${EXECDIR}/results/traces
${HAR_DIR}                            ${EXECDIR}/results/har
