#!/bin/bash # bash
#######################################################
#
# Description:Used to Test MySql BSA_database.sql
#
#######################################################


#######################################################
# For UI (curses)
#######################################################
step=1;
red=`tput setaf 1`
green=`tput setaf 2`
yellow=`tput setaf 3`
blue=`tput setaf 4`
magenta=`tput setaf 5`
cyan=`tput setaf 6`
white=`tput setaf 7`
bold=`tput bold`
curDir=`pwd`
reset=`tput sgr0`

#######################################################
# For Operations
#######################################################
# functions to process ( order matters)
functions=(preAmble checkForScripts testTables runTestProc1 complete );

# All tables in BSA_Database.sql
TABLES=(customers surveys_created questions answers survey_results);

# All get procedures for customers
#MY_PROC(GetCustomersAll GetCustomersByID GetCustomersByName GetCustomersByEmail)

shellLocation=`dirname ${0}`;
shellScript=`basename ${0}`;
step=0;

## MYSQL
SQL="mysqlsh";
SUSER="root";
SHOST="localhost";
SPWD="Pass12345";  # Password will vary from user to user
SSCHEMA="BSA_Database";
TEST1="call GetCustomersAll();";
TESTPROC1="GetCustomersAll";

#######################################################
# Functions
#######################################################

#######################################################
# Utility print out error
#
#######################################################
function handleError() 
{
	echo "${red}${bold}"
	printf >&2 "\n\tERROR: $1"" Aborted\n"; 
	resetCursor;
	exit -1; 
}

#######################################################
# Utility print out warning
#
#######################################################
function handleWarning() {
	echo "${yellow}${bold}"
	printf >&2 "\n\tWARNING: $1"" $2\n"; 
	resetCursor;
}

#######################################################
# Utility called when user aborts ( reset )
#
#######################################################
function shutdown() 
{
  tput cnorm # reset cursor
}

#######################################################
# Utility to  reset cursor
#
#######################################################
function resetCursor() 
{	
	echo "${reset}" 
}

#######################################################
# print 
#
#######################################################
function print()
{
    if [ -z $quietly ]; then
        printf "\t${green}${bold}$1";
        resetCursor;
    fi
}

#######################################################
# Utility to Print Pre-Amble
#
#######################################################
function preAmble () 
{

	clear;
	echo "${green}${bold}"
	echo ""
	echo "Starting MySql Test: '$USERNAME' "
	printf "\n\tRunning ...."
	resetCursor;	
}

#######################################################
# Utility to Print Pre-Amble function
#
#######################################################
function preAmbleFunction() 
{
	if [  -z $skipAll ]	
	then
		echo "${yellow}"
		printf "\t[Step $1] ... $2 ...\n"
	fi
}

#######################################################
# Utility for help
#
#######################################################
function help() 
{

    echo "${green}${bold}"
    echo ""
    echo "Usage: $shellScript "
    printf "\n\t -h the help\n"
    resetCursor;
    exit 0
}

#######################################################
# Command Lines
#
#######################################################
function getCommandLineArgs() 
{
	while getopts hd option
	do
		case "${option}"
		in
		  d) set -xv;;
		  h) help;;
		esac
	done

}

#######################################################
# Scripts present
#######################################################
function checkForScripts() 
{
	preAmbleFunction $1 "command '$SQL' [Validation]"
	#
	type ${SQL} >/dev/null 2>&1 || { handleWarning "$shellScript CANNOT find '$SQL' - it's not installed or found in PATH."; }
	#

	resetCursor;

}

#######################################################
# Test All Tables for data
#######################################################
function testTables()
{

	for table in "${TABLES[@]}"
	do  	  
	    print "test for data in '$table' [Validation]"
	    local CALL="SELECT * from $table;";
		local EXPECTED=`${SQL} --user=$SUSER -h $SHOST -p$SPWD --schema=$SSCHEMA -e "$CALL" --sql 2>/dev/null| wc -l | tr -d '[:space:]'`
	 
		if [[ -z $EXPECTED || "$EXPECTED" -eq "0" ]];
		then
	    	handleWarning "$table" "Did not have any database rows ('$table')";
		else
			print "SUCCESS - Found Rows [$EXPECTED] in '$table'"
		fi
	done
		
}

#######################################################
# more MqSql Tests
#######################################################
function runTestProc1()
{
	#mysqlsh --user=root -h localhost -pPass12345 --schema=BSA_Database -e call GetCustomersAll(); --sql
	preAmbleFunction $1 "Testing Stored Procedure '$TESTPROC1'"
	EXPECTED=`${SQL} --user=$SUSER -h $SHOST -p$SPWD --schema=$SSCHEMA -e "$TEST1" --sql 2>/dev/null| wc -l | tr -d '[:space:]'`
	
	if [[ -z $EXPECTED || "$EXPECTED" -eq "0" ]];
	then
	    handleWarning "runTestProc1" "Did not find any database rows with Stored Proc ('$TESTPROC1')";
	else
		print "runTestProc1 - SUCCESS - Found Rows using '$TESTPROC1'"
	fi
		
}


#######################################################
# Run MqSql Test 2
#######################################################
function runTestProc2()
{
	preAmbleFunction $1 "Testing Stored Procedure '$TESTPROC2'"
	EXPECTED=`${SQL} --user=$SUSER -h $SHOST -p$SPWD --schema=$SSCHEMA -e "$TEST2" --sql 2>/dev/null| wc -l | tr -d '[:space:]'`
	
	if [[ -z $EXPECTED || "$EXPECTED" -eq "0" ]];
	then
	    handleWarning "runTestProc2" "Did not find any database rows with Stored Proc ('$TESTPROC2')";
	else
		print "runTestProc2 - SUCCESS - Found Rows using '$TESTPROC2'"
	fi
		
}


#######################################################
# Exit msg
#######################################################
function complete() 
{
    print "\n\tDone Testing";
	resetCursor;
	
}

#######################################################
# MAIN
#
# Steps to take 
#######################################################
#reset console
trap shutdown EXIT
# cli arguments first
getCommandLineArgs "$@"
#
for functionsToCall in "${functions[@]}"
do  	  
	$functionsToCall $step;
	((step=step+1));
done
