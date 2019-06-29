intc = 1
$r[:conversion] = {}
$r[:conversion][:cidrtable] = {}
(1..32).to_a.reverse.each { |nr| 
  $r[:conversion][:cidrtable][nr] = intc
  intc += intc
}  # creates a list of CIDR notation to host count in global hash
$r[:conversion][:getcidr] = {}
$r[:conversion][:getcidr][:cmd] = method(
  def findcidr(hostcount)
    return $r[:conversion][:cidrtable].keys[$r[:conversion][:cidrtable].values.find_index(hostcount)]
  end  # Query for CIDR notation from given host count
)
$r[:conversion][:gethost] = {}
$r[:conversion][:gethost][:cmd] = method(
  def findcidr(cidrnotation)
    return $r[:conversion][:cidrtable][cidrnotation.to_i]
  end  # Query for CIDR notation from given host count
)
