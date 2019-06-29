# useful for unknown CIDR notation with given host count
# useful for unknow hostcount with given CIDR notation
# Can be moved in SYSTEM to ensure it is available at loading
intc = 1
temp = {}
(1..32).to_a.reverse.each { |nr| 
  temp[nr] = intc
  intc += intc
} # creates a list of CIDR notation to host count in global hash
$r[:conversion] = {:cidrtable => temp}
$getcidrnote = $r[:conversion][:getcidrnote] = {:cmd => method(
  def findcidr(hostcount)
    return $r[:conversion][:cidrtable].keys[$r[:conversion][:cidrtable].values.find_index(hostcount)]
  end)}  # Query for CIDR notation from given host count
$gethostcount = $r[:conversion][:gethostcount] = {:cmd => method(
  def findcidr(cidrnotation)
    return $r[:conversion][:cidrtable][cidrnotation.to_i]
  end)}  # Query for host count and return CIDR notation
#
# example usage:
#  $getcidrnote[:cmd].(4096)
#  $gethostcount[:cmd].(20)
