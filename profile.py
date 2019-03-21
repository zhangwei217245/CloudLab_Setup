"""This is a profile for reserving any number of nodes of any type. 

Instructions:
If you specify the amount of block storage, then for every node, CloudLab will try to assign a block storage of the specified amount to it, if there is sufficient total amount of block storage on the site. 
If you don't need block storage, simply put nothing for the amount of the storage. 
If you need to mount existing dataset as block storage, just paste the URN of the dataset image. 
"""
import geni.portal as portal
import geni.rspec.pg as pg

# Create the Portal context
pc = portal.Context()

# Describe the parameter this profile script can accept
pc.defineParameter("n", "Number of Raw machines", portal.ParameterType.INTEGER, 2)
pc.defineParameter("t", "Type of Raw machines", portal.ParameterType.STRING, "m510")
pc.defineParameter("i", "Disk Image of Raw machines", portal.ParameterType.STRING, "urn:publicid:IDN+emulab.net+image+emulab-ops:UBUNTU18-64-STD")
pc.defineParameter("s", "Data Space of Raw machines", portal.ParameterType.STRING, "30GB")
pc.defineParameter("p", "Path of BlockStorage", portal.ParameterType.STRING, "/block_store")
pc.defineParameter("d", "Data Image of Raw machines", portal.ParameterType.STRING, "")

# Retrieve the values the user specifies during instantiation
params = pc.bindParameters()

# Create a Request object to start building the RSpec
rspec = pg.Request()

# Check parameter validity
if params.n < 1 or params.n > 64:
    pc.reportError(portal.ParameterError( "You must choose from 1 to 64"))
    
# Create nodes and links
link = pg.LAN("lan")

for i in range (params.n):
    node = pg.RawPC("node-"+str(i))
    if params.s != '':
        bs = node.Blockstore("bs"+str(i), params.p)
        bs.size = params.s
    if params.d != '':
        bsimg = node.Blockstore("bsi"+str(i), "/reusable_data")
        bsimg.dataset = params.d
    node.hardware_type=params.t
    node.disk_image=params.i
    rspec.addResource(node)
    iface = node.addInterface("if-"+str(i))
    link.addInterface(iface)
    
    
rspec.addResource(link)

pc.printRequestRSpec(rspec)
