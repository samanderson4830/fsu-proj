//jQuery's way of selecting all elements  with class currentSurvey
$(".currentSurvey").click(function(){ //adding a click event listener with jQuery
    let selected = $(this).text().toString();
    // console.log(selected); //testing to see if string was extracted successfully
    // console.log(selected.indexOf("1")); //testing to see where surveyID is in string
    // console.log(selected.length); //testing to see size of string
    const gettingSurveyID = {
        survey: Number(selected[selected.length - 10])
    };
    // analyticsSurveyID = Number(selected[selected.length - 15]); //using difference between length and indexOf to find surveyID for <a> tag
    // console.log("analyticsSurveyID " + gettingSurveyID.survey); //testing ID value
    const jsonSurveyID = JSON.stringify(gettingSurveyID);
    // console.log(jsonSurveyID); //testing to see JSON string produced
    const browserRequest = new XMLHttpRequest();
    browserRequest.open('POST', 'http://localhost:3000/busOwn/getAnalytics', true);
    browserRequest.setRequestHeader('Content-Type', 'application/json');
    browserRequest.send(jsonSurveyID);
}); 



