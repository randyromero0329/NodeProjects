<?php
//src: http://stackoverflow.com/questions/10334753/how-to-send-an-email-with-a-csv-attachment-from-a-string  
//mysql user variables
 $mysqli = new mysqli("10.0.0.10", "pnxdgateusr", "starFl33t", "DGate2.0");

/* check connection */
if (mysqli_connect_errno()) {
    printf("Connect failed: %s\n", mysqli_connect_error());
    exit();
}

//grab all rows from the table where state is "new" and put into array
 
$query = "
SELECT \"Field1\",\"Field2\"
";
 

//loop the fetch and concactenate into string
if ($result = $mysqli->query($query)) {
        
        $data[] = array('Field1','Field2');
          while ($row = $result->fetch_assoc()) {
       $data[] = array($row['Field1'],$row['Field2']);
       }
    $result->free();
}


 

function create_csv_string($data2) {

  // Open temp file pointer
  if (!$fp = fopen('php://temp', 'w+')) return FALSE;

  // Loop data and write to file pointer
  foreach ($data2 as $line) fputcsv($fp, $line);

  // Place stream pointer at beginning
  rewind($fp);

  // Return the data
  return stream_get_contents($fp);

}


function send_csv_mail ($csvData, $body, $to = 'randy.romero@paynamics.net',  $from = 'spostmaster@notification.paynamics.net',$subject = 'Test email with attachment' ) {

  // This will provide plenty adequate entropy
  $multipartSep = '-----'.md5(time()).'-----';

  // Arrays are much more readable
  $headers = array(
    "From: $from",
    "Reply-To: $from",
    "Content-Type: multipart/mixed; boundary=\"$multipartSep\""
  );

  // Make the attachment
 
 $attachment = chunk_split(base64_encode(create_csv_string($csvData))); 

  // Make the body of the message
  $body = "--$multipartSep\r\n"
        . "Content-Type: text/plain; charset=ISO-8859-1; format=flowed\r\n"
        . "Content-Transfer-Encoding: 7bit\r\n"
        . "\r\n"
        . "$body\r\n"
        . "--$multipartSep\r\n"
        . "Content-Type: text/csv\r\n"
        . "Content-Transfer-Encoding: base64\r\n"
        . "Content-Disposition: attachment; filename=\"AFILE.csv\"\r\n"
        . "\r\n"
        . "$attachment\r\n"
        . "--$multipartSep--";

   // Send the email, return the result
   return @mail($to, $subject, $body, implode("\r\n", $headers)); 

}

  

echo "emaling now <br>";
$resp=send_csv_mail($data, "Here is Today's Report:");
 
if( $resp ){
echo "Mail sent <br>" ;
} else {
echo "Mail not sent <br>";
}
echo "fin <br>";


?> 
 