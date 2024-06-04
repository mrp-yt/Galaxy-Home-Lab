On fresh install of Proxmox VE i like to remove local-lvm storage as i don't use it. And combine local-lvm storage to main local storage.
More info 

**Video: 10+ YEARS OLD laptop is my PROXMOX server**
https://youtu.be/5ybXCED83ww?si=pWsyFhD4-AFBO5DG&t=485

**Command:**
lvremove /dev/pve/data -y && lvresize -l +100%FREE /dev/pve/root && resize2fs /dev/mapper/pve-root
