
                HTTP_STATUS=`curl -o /dev/null -s -w "%{http_code}\n" http://localhost:5000/` 
		               if [ $HTTP_STATUS -eq 200 ];
		               then
		      		        echo "TEST: SUCCES"
		               else
				            echo "TEST: FAIL"
				            exit 1
		               fi  
