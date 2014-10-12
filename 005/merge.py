#not yet functional
def mergeMax (left, right):
    result = []
    l = len(left)
    r = len(right)
    while (l > 0 and r) > 0:
        if left[0] < right[0]:
            result.append(left.pop(0))
            l -= 1
        elif right[0] < left[0]:
            result.append(right.pop(0))
            r -= 1
        else:
            result.append(left.pop(0))
            right.pop(0)
            l -= 1
            r -= 1
            
    while (l < 0):
        result.append(left.pop(0))
        l -= 1
        
    while (r < 0):
        result.append(right.pop(0))
        r -= 1
        
    return result


def dumbMergeMax (left, right):
    result = []
    if len(left) != 0:
        if len(right) != 0:
            n = max(left[-1], right[-1])
        else:
            return left 
    else:
        return right

    for i in range (n+1):
        l = left.count(i)
        r = right.count(i)
        result += ([i] * max(l,r))
    
    return result

