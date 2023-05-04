function authenticate {
	echo -n "Enter Email : "
	read EMAIL
	### Before authinetication, we want to check EMAIL is valid or no
	checkEMail ${EMAIL}
	if [ ${?} -ne 0 ]; then
		echo "The EMail is not a valid"
	else
		echo "Authentication.."
	fi
	
}

function querystudent {
	echo "Now query"
	echo -n "Enter student name to query GPA : "
	read NAME
	##We want to get line from datafile starts with NAME followed by :
	LINE=$(grep "^${NAME}:" datafile)
	if [ -z ${LINE} ]; then
		echo "Error, student name ${NAME} not found"
	else
		GPA=$(echo ${LINE} | awk ' BEGIN { FS=":" } { print $2 } ')
		echo "GPA for ${NAME} is ${GPA}"
	fi
}

function insertstudent {
	echo "Inserting a new student"
	echo -n "Enter name : "
	read NAME
	echo -n "Enter GPA : "
	read GPA
	### Before adding, we want to check GPA valid floating point or no
	checkFloatPoint ${GPA}
	if [ ${?} -ne 0 ]; then
		echo "The GPA is not a valid floating point number"
	else
		echo "Name: ${NAME}:GPA: ${GPA}" >>datafile
		echo "The Student has been added successfully"
	fi
}

function deletestudent {
	echo "Deleting an existing student"
	echo -n "Enter studen to delete : "
	read NAME
	##We want to get line from datafile starts with NAME followed by :
	LINE=$(grep "^${NAME}:" datafile)
	if [ -z ${LINE} ]; then
		echo "Error, ${NAME} not found"
	else
		##Before delete process, print confirmation message to delete or no
		echo "Are You Sure that you want to Delete ${NAME} ?(Y/N)"
		read CONFIRM
		if [ "${CONFIRM}" == "Y" ] || [ "${CONFIRM}" == "y" ]; then
			##-v used to get lines DOES NOT contain regex

			##delete student process
			grep -v "^${NAME}:" datafile >/tmp/datafile
			cp /tmp/datafile datafile
			rm /tmp/datafile
			echo "Student ${NAME} has been Deleted Successfully"
		else
			##cancel delete process
			echo "Delete Student Process is Canceled"
		fi
	fi
}

function updatestudent {
	echo "Updating an existing student"
	echo -n "Enter student Name : "
	read NAME
	##We want to get line from datafile starts with NAME followed by :
	LINE=$(grep "^${NAME}:" datafile)
	if [ -z ${LINE} ]; then
		echo "Error, student name ${NAME} not found"
	else
		echo -n "Enter GPA : "
		read GPA
		### Before adding, we want to check GPA valid floating point or no
		checkFloatPoint ${GPA}
		if [ ${?} -ne 0 ]; then
			echo "Entered GPA is not a valid floating point number"
			exit 4
		else
			##Before update process, print confirmation message to update or no
			echo "Are You Sure that you want to Update ${NAME} GPA ?(Y/N)"
			read CONFIRM
			if [ "${CONFIRM}" == "Y" ] || [ "${CONFIRM}" == "y" ]; then
				##find line  of matching pattern

				##update student GPA process
				LINE=$(grep -n "^${NAME}:" "datafile" | cut -d ':' -f1)
				UPDATE="${NAME}:${GPA}"
				sed -i "${LINE}s/.*/${UPDATE}/" "datafile"
				echo "A Student has been updated successfully"
			else
				##cancel updating a student
				echo "Update Student Process is cancelled"
			fi

		fi

	fi
}
