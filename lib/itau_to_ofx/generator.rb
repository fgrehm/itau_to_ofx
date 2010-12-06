module ItauToOfx
  class Generator
    def write(transactions, buffer)
      transactions = [transactions] unless transactions.is_a?(Array)
      
      dtasof = 
      dtserver = Date.today.strftime('%Y%m%d100000[-03:EST]')
            
      dtstart = (transactions.size > 0 ? transactions.first.date.strftime('%Y%m%d100000[-03:EST]') : dtserver)
      dtend = (transactions.size > 0 ? transactions.last.date.strftime('%Y%m%d100000[-03:EST]') : dtserver)
            
      buffer << "OFXHEADER:100
DATA:OFXSGML
VERSION:102
SECURITY:NONE
ENCODING:USASCII
CHARSET:1252
COMPRESSION:NONE
OLDFILEUID:NONE
NEWFILEUID:NONE

<OFX>
<SIGNONMSGSRSV1>
<SONRS>
<STATUS>
<CODE>0
<SEVERITY>INFO
</STATUS>
<DTSERVER>#{dtserver}
<LANGUAGE>POR
</SONRS>
</SIGNONMSGSRSV1>
<BANKMSGSRSV1>
<STMTTRNRS>
<TRNUID>1001
<STATUS>
<CODE>0
<SEVERITY>INFO
</STATUS>
<STMTRS>
<CURDEF>BRL
<BANKACCTFROM>
<BANKID>123456
<ACCTID>123456
<ACCTTYPE>CHECKING
</BANKACCTFROM>
<BANKTRANLIST>
<DTSTART>#{dtstart}
<DTEND>#{dtend}
"
  
    transactions.each {|t| write_transaction(t, buffer)}

    buffer << "</BANKTRANLIST>
<LEDGERBAL>
<BALAMT>0.00
<DTASOF>#{dtasof}
</LEDGERBAL>
</STMTRS>
</STMTTRNRS>
</BANKMSGSRSV1>
</OFX>
"
    end
    
    def write_transaction(transaction, buffer)
      type = transaction.is_a?(Transaction::Credit) ? 'CREDIT' : 'DEBIT'
      date = transaction.date.strftime('%Y%m%d100000[-03:EST]')
      id = transaction.date.strftime('%Y%m%d001')
      memo = transaction.memo
      
      amount = '%.2f' % transaction.amount
      amount = "-#{amount}" if transaction.is_a?(Transaction::Debit)
      
      buffer << "<STMTTRN>
<TRNTYPE>#{type}
<DTPOSTED>#{date}
<TRNAMT>#{amount}
<FITID>#{id}
<CHECKNUM>#{id}
<MEMO>#{memo}
</STMTTRN>
"
    end
  end
end
