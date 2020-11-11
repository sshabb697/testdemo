apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: iron-gallery-firewall
  namespace: default
spec:
  podSelector:
    matchLabels:
      run: iron-gallery
  policyTypes:
  - Ingress
  ingress:
  - from:
    
    - podSelector:
        matchLabels:
          db: mariadb
    ports:
    - protocol: TCP
      port: 3306
	  
	  
   ingress:
  - to:
    - podSelector:
        matchLabels:
          db: mariadb
  policyTypes:
  - ingress
  
  Text to Cloud

nautilus.xml

sed 's/Text/Torpedo/g' nautilus.xml
	  
	  
	  
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: iron-gallery-firewall
  namespace: default
spec:
  podSelector:
    matchLabels:
      run: iron-gallery
  ingress:
  - to:
    - podSelector:
        matchLabels:
          db: mariadb
  policyTypes:
  - ingress
