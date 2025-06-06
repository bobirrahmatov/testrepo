Sub QueryWebsiteAndExtractData()
    Dim bot As New Selenium.ChromeDriver
    Dim ws As Worksheet
    Dim i As Long
    Dim inputValue As String
    Dim resultText As String
    
    Set ws = ThisWorkbook.Sheets("Sheet1") ' change to your sheet name

    ' Start browser
    bot.Start "Chrome"
    bot.Get "https://your-target-website.com" ' Replace with actual website

    i = 2 ' Start from row 2
    Do While ws.Cells(i, 1).Value <> ""
        inputValue = ws.Cells(i, 1).Value
        
        ' Find the input box and enter the value
        On Error Resume Next
        bot.FindElementByName("cwrelid").Clear
        bot.FindElementByName("cwrelid").SendKeys inputValue
        
        ' Click the button
        bot.FindElementByName("but_rltnshop").Click
        bot.Wait 2000 ' Wait for results to load (adjust if needed)

        ' Extract data from the result cell
        resultText = ""
        On Error Resume Next
        resultText = bot.FindElementByCss("td.bodytextnormal").Text
        On Error GoTo 0
        
        ' Write to Column B
        ws.Cells(i, 2).Value = resultText
        
        i = i + 1
    Loop

    MsgBox "Done extracting data!"
    bot.Quit
End Sub
