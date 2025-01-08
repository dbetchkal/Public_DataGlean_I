__all__ = ['read_Dataglean_json'
]

def read_Dataglean_json(path, x_to_log=False, y_to_log=False, x_from_log=False, y_from_log=False):
    
    '''
    A function to read in results from `Public_DataGlean_I.pde`, a Processing-based
     graph digitization tool. 
    '''
    
    import json
    
    def mapFromTo(x,a,b,c,d):
        '''
        x:input value; 
        a,b:input range
        c,d:output range
        y:return value
        '''

        y=(x-a)/(b-a)*(d-c)+c

        return y
    
    # Opening JSON file
    f = open(path)
    raw = json.load(f)
    
    values = pd.DataFrame([raw['x'], raw['y']], index=["x", "y"]).T # compile the point values

    try:
        bounds = raw['bounds']
        x_min, y_min, x_max, y_max = bounds
        print(x_min, y_min, x_max, y_max)
        v = raw['version'][0]
        print("Using `Public_DataGlean_I` version", v)
        
    except KeyError:
        print("This function is back-compatable only for linear axes. Please confirm you are using `Public_DataGlean_I` v1.1 if you are using log-axes.")
        bounds = None
    
    if(x_to_log):
        rescale_x = [np.power(10, mapFromTo(r, x_min, x_max, np.log10(x_min), np.log10(x_max))) for r in values.x]
        values.x = rescale_x
        
    if(x_from_log):
        rescale_x = [np.power(10, mapFromTo(r, np.log10(x_min), np.log10(x_max), x_min, x_max)) for r in values.x]
        values.x = rescale_x

    if(y_to_log):
        rescale_y = [np.power(10, mapFromTo(r, y_min, y_max, np.log10(y_min), np.log10(y_max))) for r in values.y]
        values.y = rescale_y
        
    if(y_from_log):
        rescale_y = [np.power(10, mapFromTo(r, np.log10(y_min), np.log10(y_max), y_min, y_max)) for r in values.y]
        values.y = rescale_y
    
    return values, bounds