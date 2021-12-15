*** Settings ***
Documentation    Suite description
Library     SeleniumLibrary

*** Variable ***
${sidebar_loading}  //*[contains(@aria-label, 'Loading interface..')]
${chart_loading}    //*[contains(@class, 'chart-container__loader')]
${cq_symbol}    //*[contains(@class, 'cq-symbol-select-btn')]
${synthetic}    //*[text()="Synthetic Indices"]
${v10}  //*[text()="Volatility 10 (1s) Index"]
${tick5}    //span[contains(@data-value, '5')]
${dropdown}     //*[contains(@id, 'dt_contract_dropdown')]
${risefall}     //*[contains(@id, 'dt_contract_rise_fall_item')]
${forex}    //*[text()="Forex"]
${AUD/USD}      //*[text()="AUD/USD"]
${higherlower}      //*[contains(@id, 'dt_contract_high_low_item')]
${datepicker}      //input[@class="dc-input__field"]
${payout}      //input[@id="dt_amount_input"]
${buttondisabled}       //*[contains(@class, 'trade-container__fieldset-wrapper trade-container__fieldset-wrapper--disabled')]
${barrierError}     //*[text()="Contracts more than 24 hours in duration would need an absolute barrier."]
#${v50}  //*[contains(@class, "sc-mcd__item sc-mcd__item--R_50 sc-mcd__item--selected ")]
${v50}  //*[text()="Volatility 50 Index"]
${stake}    //*[contains(@class, "trade-container__fieldset-info trade-container__fieldset-info--left")]
${leftTab}  //*[contains(@class, "sc-mcd__tabs")]
${openTab}  //*[contains(@class, "sc-mcd__content")]
${multiplierDropdown}   //*[contains(@class, "dc-dropdown__container")]
${multiplierLeftTab}    //*[contains(@class, "dc-list dc-list--left")]
${x20}  //*[contains(@id, 20)]
${x40}  //*[contains(@id, 40)]
${x60}  //*[contains(@id, 60)]
${x100}  //*[contains(@id, 100)]
${x200}  //*[contains(@id, 200)]
${takeProfit}       //*[contains(@class, "dc-checkbox take_profit-checkbox__input")]
${stopLoss}         //*[contains(@class, "dc-checkbox stop_loss-checkbox__input")]
${dealCancellation}     //*[contains(@for, "dt_cancellation-checkbox_input")]
${takeProfitChecked}   //*[@class="dc-checkbox take_profit-checkbox__input"]//*[@class="dc-checkbox__box dc-checkbox__box--active"]
${stopLossChecked}     //*[@class="dc-checkbox stop_loss-checkbox__input"]//*[@class="dc-checkbox__box dc-checkbox__box--active"]
${dealCancellationChecked}     //*[@class="dc-checkbox"]//*[@class="dc-checkbox__box dc-checkbox__box--active"]
${stakeInput}       //*[contains(@class, "dc-input-field trade-container__amount")]
${stakeInvalidMax}     //*[text()="Maximum stake allowed is 2000.00."]
${stakeInvalidMin}      //*[contains(@data-tooltip, "Please enter a stake amount that's at least 1.00.")]
${cancelDropdown}       //*[contains(@class, "dc-list dc-list--left")]
${cancel}       //*[contains(@name, "cancellation_duration")]
${5m}   //*[contains(@id, "5m")]
${10m}   //*[contains(@id, "10m")]
${15m}   //*[contains(@id, "15m")]
${30m}   //*[contains(@id, "30m")]
${60m}   //*[contains(@id, "60m")]

*** Keywords ***
Login
    [arguments]     ${email}    ${pw}   ${login}    ${em_field}
    Open Browser    https://app.deriv.com   chrome
    set window size     1280    1028
    Wait until page contains element    ${login}     10
    click button    ${login}
    wait until page contains element    txtEmail   10
    input text      ${em_field}      ${email}
    input password      txtPass     ${pw}
#   input text      //*[@type="password"] || //*[type()="Log in"]
    click button    login
    wait until page does not contain element    dt_core_header_acc-info-preloader  60
    click element    dt_core_account-info_acc-info
    click element    dt_core_account-switcher_demo-tab
    click element    class=acc-switcher__accounts

Task2
    wait until page does not contain element    ${chart_loading}     60
    click element   ${cq_symbol}
    click element   ${synthetic}
    click element   ${v10}
    wait until page does not contain element    ${sidebar_loading}  60
    click element   ${dropdown}
    click element   ${risefall}
#    set element attribute   dt_duration_range_input     value   1
    click element   ${tick5}
    click element   dt_purchase_call_button

Task3
    wait until page does not contain element    ${chart_loading}     60
    wait until page does not contain element    ${sidebar_loading}  60
    wait until page does not contain element    dt_core_header_acc-info-preloader  60
    click element   ${cq_symbol}
    click element   ${forex}
    click element   ${AUD/USD}
    wait until page does not contain element    ${sidebar_loading}  60
    click element   ${dropdown}
    click element   ${higherlower}
    wait until page contains element    ${datepicker}  60
    ${current_value}=   get element attribute   ${datepicker}   value
    ${value_length}=    get length  ${current_value}
    Repeat Keyword     ${value_length}     press keys      ${datepicker}      BACKSPACE
    Repeat Keyword     1    press keys      ${datepicker}      DELETE
#    click element   ${datepicker}
#    clear element text  ${datepicker}
    input text  ${datepicker}   2
#    element attribute value should be   ${datepicker}   2
    click button    dc_payout_toggle_item
    ${current_value}=   get element attribute   ${payout}   value
    ${value_length}=    get length  ${current_value}
    Repeat Keyword     ${value_length}     press keys      ${payout}      BACKSPACE
    Repeat Keyword     1    press keys      ${payout}      DELETE
    input text  ${payout}   15.50
#    click element   ${payout}
#    clear element text  ${payout}
#    input text  ${payout}   15.50
#    element attribute value should be   ${payout}   15.50
    wait until page does not contain element    ${buttondisabled}   60
    wait until page contains element    dt_purchase_put_button     60
    click element    dt_purchase_put_button

Task4
    wait until page does not contain element    ${chart_loading}     60
    click element   ${cq_symbol}
    click element   ${forex}
    click element   ${AUD/USD}
    wait until page does not contain element    ${sidebar_loading}  60
    click element   ${dropdown}
    click element   ${higherlower}
    wait until page contains element    ${datepicker}  60
    ${current_value}=   get element attribute   ${datepicker}   value
    ${value_length}=    get length  ${current_value}
    Repeat Keyword     ${value_length}     press keys      ${datepicker}      BACKSPACE
    Repeat Keyword     1    press keys      ${datepicker}      DELETE
    input text  ${datepicker}   2
    click button    dc_payout_toggle_item
    ${current_value}=   get element attribute   dt_barrier_1_input   value
    ${value_length}=    get length  ${current_value}
    Repeat Keyword     ${value_length}     press keys      dt_barrier_1_input      BACKSPACE
    Repeat Keyword     1    press keys      dt_barrier_1_input      DELETE
    input text  dt_barrier_1_input   +1
    ${current_value}=   get element attribute   ${payout}   value
    ${value_length}=    get length  ${current_value}
    Repeat Keyword     ${value_length}     press keys      ${payout}      BACKSPACE
    Repeat Keyword     1    press keys      ${payout}      DELETE
    input text  ${payout}   10
    wait until page contains element    ${barrierError}     60
    element text should be   ${barrierError}    Contracts more than 24 hours in duration would need an absolute barrier.

Task5
    wait until page does not contain element    ${chart_loading}     60
    click element   ${cq_symbol}
    wait until page contains element    ${leftTab}
    click element   ${synthetic}
    wait until page contains element    ${openTab}
    click element   ${v50}
    wait until page does not contain element    ${sidebar_loading}  60
    click element   ${dropdown}
    click element   dt_contract_multiplier_item
    element text should be  ${stake}    Stake
    click element   ${multiplierDropdown}
    wait until page contains element    ${multiplierLeftTab}
    element attribute value should be   ${x20}  value   20
    element attribute value should be   ${x40}  value   40
    element attribute value should be   ${x60}  value   60
    element attribute value should be   ${x100}  value   100
    element attribute value should be   ${x200}  value   200
    click element   ${takeProfit}
    click element   ${stopLoss}
    click element   ${takeProfit}
    click element   ${stopLoss}
    click element   ${dealCancellation}
    checkbox should not be selected     dc_take_profit-checkbox_input
    checkbox should not be selected     dc_stop_loss-checkbox_input
    ${current_value}=   get element attribute   dt_amount_input   value
    ${value_length}=    get length  ${current_value}
    Repeat Keyword     ${value_length}     press keys      dt_amount_input     BACKSPACE
    Repeat Keyword     1    press keys      dt_amount_input      DELETE
    input text  dt_amount_input   2001
    wait until page contains element    ${stakeInvalidMax}  60
    element text should be  ${stakeInvalidMax}     Maximum stake allowed is 2000.00.
    ${current_value}=   get element attribute   dt_amount_input  value
    ${value_length}=    get length  ${current_value}
    Repeat Keyword     ${value_length}     press keys      dt_amount_input      BACKSPACE
    Repeat Keyword     1    press keys     dt_amount_input      DELETE
    input text  dt_amount_input   0
    wait until page contains element    ${stakeInvalidMin}  60
    element attribute value should be    ${stakeInvalidMin}     data-tooltip    Please enter a stake amount that's at least 1.00.
    ${current_value}=   get element attribute   dt_amount_input  value
    ${value_length}=    get length  ${current_value}
    Repeat Keyword     ${value_length}     press keys      dt_amount_input      BACKSPACE
    Repeat Keyword     1    press keys     dt_amount_input      DELETE
    input text  dt_amount_input   10
    click element   ${takeProfit}
    click element   ${stopLoss}
    ${current_value}=   get element attribute   dc_take_profit_input  value
    ${value_length}=    get length  ${current_value}
    Repeat Keyword     ${value_length}     press keys      dc_take_profit_input      BACKSPACE
    Repeat Keyword     1    press keys     dc_take_profit_input      DELETE
    input text  dc_take_profit_input   1
    click button    dc_take_profit_input_add
    element attribute value should be   dc_take_profit_input    value   2
    ${current_value}=   get element attribute   dc_take_profit_input  value
    ${value_length}=    get length  ${current_value}
    Repeat Keyword     ${value_length}     press keys      dc_take_profit_input      BACKSPACE
    Repeat Keyword     1    press keys     dc_take_profit_input      DELETE
    input text  dc_take_profit_input   2
    click button    dc_take_profit_input_sub
    element attribute value should be   dc_take_profit_input    value   1
    click element   ${dealCancellation}
    click element   ${cancel}
    wait until page contains element    ${cancelDropdown}
    element attribute value should be   ${5m}  value   5m
    element attribute value should be   ${10m}  value   10m
    element attribute value should be   ${15m}  value   15m
    element attribute value should be   ${30m}  value   30m
    element attribute value should be   ${60m}  value   60m






