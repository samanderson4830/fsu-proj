$(".surveyClicked").click(function(){ 
    let selected = $(this).text().toString();
    // console.log(selected); //testing to see if string was extracted successfully
    // console.log(selected.indexOf("1")); //testing to see where surveyID is in string
    // console.log(selected.length); //testing to see size of string
    analyticsSurveyID = Number(selected[selected.length - 15]); //using difference between length and indexOf to find surveyID
    // console.log(analyticsSurveyID); //testing ID value
});

//trying to figure out a way to get analyticsSurveyID out of script file and
// and accessed in controller 


