# 
# allows you to import a python module by giving the file path
# ie importFile( "/foo/bar/myModule.py" )
# instead of sys.path.append( "/foo/bar" ) and import( "myModule" )
#

def importFile(path):
    from os.path import basename, isdir, splitext
    import imp
    import base64
    if isdir(path):
    	realPath = join(path, "__init__.py")
    	coreName = base64.encodestring(realPath)
    	try:
    		mod = imp.load_source(coreName, realPath)
    	except IOError:
    		raise IOError("Failed to load directory module: %s\n" % path)
    else:
    	baseName = basename(path)
    	(coreName, ext) = splitext(baseName)
    	coreName = base64.encodestring(path)
    	if ext == ".so":
    		try:
    			return imp.load_dynamic(coreName, path)
    		except IOError:
    			raise IOError("Failed to load dynamic module: %s\n" % path)
    	else:
    		try:
    			mod = imp.load_source(coreName, path)
    		except IOError:
    			raise IOError("Failed to load source module: %s\n" % path)
    return mod

