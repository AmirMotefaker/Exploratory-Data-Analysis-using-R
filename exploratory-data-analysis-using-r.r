{
 "cells": [
  {
   "cell_type": "markdown",
   "id": "e55bfb1c",
   "metadata": {
    "papermill": {
     "duration": 0.002994,
     "end_time": "2023-01-25T06:22:29.192636",
     "exception": false,
     "start_time": "2023-01-25T06:22:29.189642",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "# Prerequisites"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 1,
   "id": "2ff70a9f",
   "metadata": {
    "_cell_guid": "b1076dfc-b9ad-4769-8c92-a6c4dae69d19",
    "_uuid": "8f2839f25d086af736a60e9eeb907d3b93b6e0e5",
    "execution": {
     "iopub.execute_input": "2023-01-25T06:22:29.202213Z",
     "iopub.status.busy": "2023-01-25T06:22:29.199672Z",
     "iopub.status.idle": "2023-01-25T06:22:30.748855Z",
     "shell.execute_reply": "2023-01-25T06:22:30.747098Z"
    },
    "papermill": {
     "duration": 1.557116,
     "end_time": "2023-01-25T06:22:30.752144",
     "exception": false,
     "start_time": "2023-01-25T06:22:29.195028",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "name": "stderr",
     "output_type": "stream",
     "text": [
      "── \u001b[1mAttaching packages\u001b[22m ─────────────────────────────────────── tidyverse 1.3.2 ──\n",
      "\u001b[32m✔\u001b[39m \u001b[34mggplot2\u001b[39m 3.4.0      \u001b[32m✔\u001b[39m \u001b[34mpurrr  \u001b[39m 1.0.1 \n",
      "\u001b[32m✔\u001b[39m \u001b[34mtibble \u001b[39m 3.1.8      \u001b[32m✔\u001b[39m \u001b[34mdplyr  \u001b[39m 1.0.10\n",
      "\u001b[32m✔\u001b[39m \u001b[34mtidyr  \u001b[39m 1.2.1      \u001b[32m✔\u001b[39m \u001b[34mstringr\u001b[39m 1.5.0 \n",
      "\u001b[32m✔\u001b[39m \u001b[34mreadr  \u001b[39m 2.1.3      \u001b[32m✔\u001b[39m \u001b[34mforcats\u001b[39m 0.5.2 \n",
      "── \u001b[1mConflicts\u001b[22m ────────────────────────────────────────── tidyverse_conflicts() ──\n",
      "\u001b[31m✖\u001b[39m \u001b[34mdplyr\u001b[39m::\u001b[32mfilter()\u001b[39m masks \u001b[34mstats\u001b[39m::filter()\n",
      "\u001b[31m✖\u001b[39m \u001b[34mdplyr\u001b[39m::\u001b[32mlag()\u001b[39m    masks \u001b[34mstats\u001b[39m::lag()\n"
     ]
    }
   ],
   "source": [
    "library(tidyverse)"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "4b43a001",
   "metadata": {
    "papermill": {
     "duration": 0.001993,
     "end_time": "2023-01-25T06:22:30.756374",
     "exception": false,
     "start_time": "2023-01-25T06:22:30.754381",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "# Variation"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "6f18066c",
   "metadata": {
    "papermill": {
     "duration": 0.001849,
     "end_time": "2023-01-25T06:22:30.760189",
     "exception": false,
     "start_time": "2023-01-25T06:22:30.758340",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "##  Visualising distributions"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 2,
   "id": "8d56d0c2",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-01-25T06:22:30.796418Z",
     "iopub.status.busy": "2023-01-25T06:22:30.766041Z",
     "iopub.status.idle": "2023-01-25T06:22:31.499335Z",
     "shell.execute_reply": "2023-01-25T06:22:31.497594Z"
    },
    "papermill": {
     "duration": 0.741194,
     "end_time": "2023-01-25T06:22:31.503318",
     "exception": false,
     "start_time": "2023-01-25T06:22:30.762124",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "image/png": "iVBORw0KGgoAAAANSUhEUgAAA0gAAANICAIAAAByhViMAAAABmJLR0QA/wD/AP+gvaeTAAAg\nAElEQVR4nO3deWCcZb347XsyM5ksTdPSIKUFKaWsRRDkHCwcqFRQcaGIRRAsBVlk0cqxCggt\nWwF/HLXUIvumsiOboijKi4AKIlAXELAoaFlL17Rpm21m3j9SQ0CyDG0ymXuu66/J/cwk38n9\nNPl0MpMk8vl8AACg9FUUewAAADYMYQcAEAlhBwAQCWEHABAJYQcAEAlhBwAQCWEHABAJYQcA\nEIlUsQcojpaWljVr1hR7iqJJpVK1tbUhhFWrVuVyuWKPQy/S6XRNTU0IobGxsdiz0LtMJlNV\nVZXP51euXFnsWehdVVVVJpPJZrNNTU3FnoXe1dTUpNPp9vb21atXF3uWYho+fHh3h8o07PL5\nfDabLfYURVNRUVFRURFCyOVy5fx5KBWpVKpjv2xWScjn8xUVFf5xlRD7VVp8PeyZH8UCAESi\nTB+xSyQS6XS62FMUTSqV6rzQ8V8fBrNkMtlxoZxP2hLSsV9l/kWmhHR8DbRfpaJjvyoqKuxX\ndxL5fL7YMxRBW1tbZ9yUp0QiEUIoz90vRfartNivEtKxWcF+lQj7FULIZrM9NEyZxk02my3n\n56Gn0+n6+voQwooVKzxNYfDLZDJ1dXUhhKVLlxZ7FnpXXV1dW1uby+WWLVtW7FnoXW1tbXV1\ndXt7+4oVK4o9C72rq6vLZDKtra1l/uKkhoaG7g75MRwAQCSEHQBAJIQdAEAkhB0AQCSEHQBA\nJIQdAEAkhB0AQCSEHQBAJIQdAEAkhB0AQCSEHQBAJIQdAEAkhB0AQCSEHQBAJIQdAEAkhB0A\nQCSEHQBAJIQdAEAkhB0AQCSEHQBAJIQdAEAkhB0AQCSEHQBAJIQdAEAkhB0AQCSEHQBAJIQd\nAEAkhB0AQCSEHQBAJFLFHgAAGCDTp08v9giEEMK8efP66T17xA4AIBLCDgAgEsIOACASwg4A\nIBLCDgAgEsIOACASwg4AIBLCDgAgEsIOACASwg4AIBLCDgAgEsIOACASwg4AIBLCDgAgEsIO\nACASwg4AIBLCDgAgEsIOACASwg4AIBLCDgAgEsIOACASwg4AIBLCDgAgEsIOACASwg4AIBLC\nDgAgEsIOACASwg4AIBLCDgAgEsIOACASwg4AIBLCDgAgEsIOACASwg4AIBLCDgAgEsIOACAS\nwg4AIBLCDgAgEsIOACASwg4AIBLCDgAgEsIOACASwg4AIBLCDgAgEsIOACASqYH5MPn25Xdd\ndcXPH/nz0uaKTTff+oCpx390l5EhhBByD95y6T0Pz39pVXL7HXc/cvpRW1Yn/32j7g4Vug4A\nUBYG6BG7X17wtRsefP2TR06/cPapk7ZqufTsk378UlMI4YU7Zl5066MTDjr2rJOPqPnH/Wd8\n9ar8v2/S3aFC1wEAysRAPGKXbXnp8ieXTLzg25PHDw8hbL3d+177wyE/vvy5yeftNOfWZ8dN\nnTNl3y1DCOMuDAdP+9bNr009bNPakG9950Mj04Wtb1o7AHcQAGAwGJCwa/7nFltu+fGxdf9e\nSOxSn/l9Y1NL48MLm7PTJ43qWM0M32vnId99/KFFhx06trtDn/nYCwWtH3bo2M4xVq1alc+v\nexQvl8slEol+v+eDVdf7Xs6fh1LRuUc2q4QkEgn7VVrsFwOp/863gQi7yvq95s7dq/PNtqbn\nrn21acyx41pX3xZC2KHmzRnG16R++XRjCKF19V/e8VDrXoWtdx1j//33b25u7rg8efLkWbNm\nbcg7WZqGDx9e7BEowIgRI4o9An2VSCTsVwlJpVL2i4G0PudbNpvt4egAvXii0z8f/9nF865r\nH/vx0/cb3fbP1SGEhvSbL3FoSCfbVraFEHIt73yo0PV+vz8AAIPGwIVdy/Lnrv3uxb/487KJ\nU044/7BJVYnEqkxNCGFZW25k5brXcCxpy6aGp0IIFd0cKnS96wDnnntuLpfruLzxxhuvWrWq\nn+/x4JVMJmtqakIIq1ev7vycMGilUqnq6uoQQjmftCWksrIyk8nk8/mmpqZiz0LvMplMZWVl\nLpdbvXp1sWehjKzP1/N8Pj906NDujg5Q2K168f4ZX78kudP+/3fVEds2VHUspmveF8JDz61t\nG1mZ6VhZsLa9fnx9D4cKXe86w6RJkzovNzc3l/PX3HQ63XGhtbW150d0GVRaWlqKPQK9q6io\n6Ag7+1USUqlUCCGXy9kvBlL/nW8D8etO8rk153/jssyHv3zpmcd1Vl0IoWrYPqMrk/c+srjj\nzbam+U+sat11n5E9HCp0fQDuHQDAIDEQj9itef36Z9a0Hb1T7ZNPPNG5mK7eeufx9TOmbPf1\na85+YJNTthvW8uOL59SO3m/qqNoQQkikuztU6DoAQJkYiLBr/Ns/QwjXXHh+18X6sbOun/tf\n4w4578SWuTfNmbW0ObHVzhNnzzi28+W/3R0qdB0AoEwkOn+1W1nxHLv6+voQwvLlyz3HbvDL\nZDJ1dXUhhCVLlhR7FnpXXV1dW1uby+WWLVtW7FnoXW1tbXV1dXt7+4oVK4o9y0CYPn16sUcg\nhBDmzZu3PjdvaGjo7tAA/UkxAAD6m7ADAIiEsAMAiISwAwCIhLADAIiEsAMAiISwAwCIhLAD\nAIiEsAMAiISwAwCIhLADAIiEsAMAiISwAwCIhLADAIiEsAMAiISwAwCIhLADAIiEsAMAiISw\nAwCIhLADAIiEsAMAiISwAwCIhLADAIiEsAMAiISwAwCIhLADAIiEsAMAiISwAwCIhLADAIiE\nsAMAiISwAwCIhLADAIiEsAMAiISwAwCIhLADAIiEsAMAiISwAwCIhLADAIiEsAMAiISwAwCI\nhLADAIiEsAMAiISwAwCIhLADAIiEsAMAiISwAwCIhLADAIiEsAMAiISwAwCIhLADAIiEsAMA\niISwAwCIhLADAIiEsAMAiISwAwCIhLADAIiEsAMAiISwAwCIhLADAIiEsAMAiISwAwCIhLAD\nAIiEsAMAiISwAwCIhLADAIiEsAMAiISwAwCIhLADAIiEsAMAiISwAwCIhLADAIiEsAMAiISw\nAwCIhLADAIhEqtgDFEdFRUVdXV2xpyiaiop1QV9bW5vP54s7DL3q3K9yPmlLSDKZDCEkEgn7\nVRJSqVQIIZlM2i8G0vqcbz1/4y7TsAsh5HK5Yo9QfLlcTtgNfolEouOCk7YkdIa4/SoJHV8D\n8/m8/WIgrc/51vNtyzTscrnc6tWriz1F0aTT6UwmE0JYu3ZtNpst9jj0IpPJVFZWhhDK+aQt\nIdXV1el0Op/P26+SUFtbm0qlyvybAgNvPc+32tra7g55jh0AQCSEHQBAJIQdAEAkhB0AQCSE\nHQBAJIQdAEAkhB0AQCSEHQBAJIQdAEAkhB0AQCSEHQBAJIQdAEAkhB0AQCSEHQBAJIQdAEAk\nhB0AQCSEHQBAJIQdAEAkhB0AQCSEHQBAJIQdAEAkhB0AQCSEHQBAJIQdAEAkhB0AQCSEHQBA\nJIQdAEAkhB0AQCSEHQBAJIQdAEAkhB0AQCSEHQBAJIQdAEAkhB0AQCSEHQBAJIQdAEAkhB0A\nQCSEHQBAJIQdAEAkhB0AQCSEHQBAJIQdAEAkhB0AQCSEHQBAJIQdAEAkhB0AQCSEHQBAJIQd\nAEAkhB0AQCSEHQBAJIQdAEAkhB0AQCSEHQBAJIQdAEAkhB0AQCSEHQBAJIQdAEAkhB0AQCSE\nHQBAJIQdAEAkhB0AQCSEHQBAJIQdAEAkhB0AQCSEHQBAJIQdAEAkhB0AQCSEHQBAJIQdAEAk\nhB0AQCSEHQBAJIQdAEAkhB0AQCSEHQBAJFID/PG+f8K0qnMvP3Tj6o43Fz16xrHffKrrFb74\ng9s+MbwqhBBC7sFbLr3n4fkvrUpuv+PuR04/asvq5LtaBwAoCwMZdvm///a6u15dcXA+37m0\n4k8rqkd86ivHju9cGVtb2XHhhTtmXnTrv6ae9KUvDG//6RWXnPHV9hsvOz5R+DoAQJkYoLB7\n/TdzZ175uzcaW962/sYzK4ftsMcee4x/+w3yrXNufXbc1DlT9t0yhDDuwnDwtG/d/NrUw0am\nC1vftHYg7h4AwCAwQM+x22inKaed9c1vX3jq29b/vLJl+C7DsmtXvv7GinyX9ZbGhxc2Z/ef\nNKrjzczwvXYeUvn4Q4sKXe/v+wUAMHgM0CN2lfWbjasP2daqt63/sakt99t5n734ubZ8PlW7\n8UcP+8oXP7VTCKF19V9CCDvUvDne+JrUL59ubN2rsPWuH+vGG29sb2/vuDxmzJjddtttw97H\nEpJMrnv2YSaTyefzPV+Zokul1p3Y1dXVxZ2Evkin0yGERCJhv0pCx7+viooK+8VAWp/zredv\n3AP94omusq2vNCaSYzaacOFNs+uzK3//s6u/c9XMzNY/PHK7YbmW1SGEhvSbr35oSCfbVrYV\nut71w1122WXNzc0dlydPnjxx4sT+vHOloaamptgjUIDaWk8tKBmJRMJ+lZCKigr7xUBan/Mt\nm832cLSYYZesHH377bf/+62GiZ87bcEvD3ng6qeP/Pb/VGRqQgjL2nIjK9f9sHhJWzY1PFXo\netcPV1dXV1m57pUZVVVVZf5IVSKRCL1VP4OH/Sot9quEdGxWsF8MrPU53wbvI3b/6QPvqX5g\n+eIQQrrmfSE89NzatpGVmY5DC9a214+vL3S96zv/+c9/3nm5ubl56dKlA3GXBqV0Ol1fXx9C\nWLFiRc/hz2CQyWTq6upCCOV80paQ6urq2traXC63bNmyYs9C72pra6urq9vb21esWFHsWSgj\n6/n1vKGhobtDxfwFxSsWXHL0MSctas2tezuffei1NcN22CaEUDVsn9GVyXsfWdxxpK1p/hOr\nWnfdZ2Sh6wN9lwAAiqeYYTd07CEj1iw69Zwrnnh6wfN//dPNc095eHXdccdsE0IIifSMKds9\nf83ZD8xf8OoLT109a07t6P2mjqoteB0AoGwU80exFamG2Zecc93lN373vNObU0PHjtvx1Lnn\n7jIk3XF03CHnndgy96Y5s5Y2J7baeeLsGccm3tU6AECZSJTn00Wbm5ubmpqKPUXRdD7Hbvny\n5Z5jN/h1PsduyZIlxZ6F3nmOXWkpt+fYTZ8+vdgjEEII8+bNW5+bD9Ln2AEAsAEJOwCASAg7\nAIBICDsAgEgIOwCASAg7AIBICDsAgEgIOwCASAg7AIBICDsAgEgIOwCASAg7AIBICDsAgEgI\nOwCASAg7AIBICDsAgEgIOwCASAg7AIBICDsAgEgIOwCASAg7AIBICDsAgEgIOwCASAg7AIBI\nCDsAgEgIOwCASAg7AIBICDsAgEgIOwCASAg7AIBICDsAgEgIOwCASAg7AIBIpIo9AAAlbPr0\n6cUegRBCmDdvXrFHYFDwiB0AQCSEHQBAJIQdAEAkhB0AQCSEHQBAJIQdAEAkhB0AQCSEHQBA\nJIQdAEAkhB0AQCSEHQBAJIQdAEAkhB0AQCSEHQBAJIQdAEAkhB0AQCSEHQBAJIQdAEAkhB0A\nQCSEHQBAJIQdAEAkhB0AQCSEHQBAJIQdAEAkhB0AQCSEHQBAJIQdAEAkhB0AQCSEHQBAJIQd\nAEAkhB0AQCSEHQBAJIQdAEAkhB0AQCSEHQBAJIQdAEAkhB0AQCSEHQBAJIQdAEAkhB0AQCRS\nxR6gaBKJRLFHKJqu972cPw+lonOPbFYJSSQS9ouB5HwrLf23X2UadslkcsSIEcWeoviGDx9e\n7BEogJO2hCQSCfvFQHK+lZb12a9sNtvD0TINu2w229TUVOwpiiaVStXV1YUQGhsbc7lcsceh\nF5WVlbW1tSGE5cuXF3sWeldVVVVdXZ3P51esWFHsWSgjvj6UlvXZr3w+v9FGG3V3tEzDLvQW\nvHGrqFj33MpcLlfOn4dS0RnfNqskdOxXPp+3Xwwk51tp6b/98uIJAIBICDsAgEgIOwCASAg7\nAIBICDsAgEgIOwCASAg7AIBICDsAgEgIOwCASAg7AIBICDsAgEiU79+KBQan6dOnF3sEQghh\n3rx5xR4BKJhH7AAAIiHsAAAiIewAACIh7AAAIiHsAAAiIewAACIh7AAAIiHsAAAiIewAACIh\n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\nkslkVVVVCGHNmjX5vBeZDHapVCqTyYQQyvmkZeA530qL/Sot67Nf+Xx+yJAh3R0tZtila94X\nwkPPrW0bWZnpWFmwtr1+fH0Phwpd7/rhDj/88M7Lzc3NTU1N/X0HB610Ot0Rdi0tLdlsttfr\nU1yZTKYj7NauXVvsWSgjzrfSYr9Ky3ruVw9hV+CLJzaoqmH7jK5M3vvI4o4325rmP7Gqddd9\nRvZwqND1Ab9PAABFU8ywC4n0jCnbPX/N2Q/MX/DqC09dPWtO7ej9po6q7elQoesAAGWjmD+K\nDSGMO+S8E1vm3jRn1tLmxFY7T5w949hEb4cKXQcAKBMDGnbJys1+8pOfvGUpkdxv2oz9pr3T\ntbs7VOg6AEB5KOqPYgEA2HCEHQBAJIQdAEAkhB0AQCSEHQBAJIQdAEAkhB0AQCSEHQBAJIQd\nAEAkhB0AQCSEHQBAJIQdAEAkhB0AQCSEHQBAJIQdAEAkhB0AQCSEHQBAJIQdAEAkhB0AQCSE\nHQBAJIQdAEAkhB0AQCSEHQBAJIQdAEAkhB0AQCSEHQBAJIQdAEAkhB0AQCSEHQBAJIQdAEAk\nhB0AQCSEHQBAJIQdAEAkhB0AQCSEHQBAJIQdAEAkhB0AQCSEHQBAJIQdAEAkhB0AQCSEHQBA\nJIQdAEAkhB0AQCSEHQBAJIQdAEAkhB0AQCSEHQBAJIQdAEAkhB0AQCSEHQBAJIQdAEAkhB0A\nQCSEHQBAJIQdAEAkhB0AQCSEHQBAJIQdAEAkhB0AQCSEHQBAJIQdAEAkhB0AQCSEHQBAJIQd\nAEAkhB0AQCSEHQBAJIQdAEAkhB0AQCSEHQBAJIQdAEAkhB0AQCSEHQBAJIQdAEAkhB0AQCSE\nHQBAJFLFHqA4EolEdXV1sacommQy2XEhk8nk8/niDkOvUql1/07L+aRl4DnfSov9Ki3rs189\nf+Mu37CrrKws9hRFk0gkOi5UVlYKu8GvomLdI+vlfNIy8JxvpcV+lZb12a9cLtfD0TINu1wu\n19TUVOwpiiadTtfX14cQVq1alc1miz0OvchkMnV1dSGExsbGYs9CGXG+lRb7VVrWc78ymUx3\nhzzHDgAgEsIOACASwg4AIBLCDgAgEsIOACASwg4AIBLCDgAgEsIOACASwg4AIBLCDgAgEsIO\nACASwg4AIBLCDgAgEsIOACASwg4AIBLCDgAgEsIOACASwg4AIBLCDgAgEsIOACASwg4AIBLC\nDgAgEsIOACASwg4AIBLCDgAgEsIOACASwg4AIBLCDgAgEsIOACASwg4AIBLCDgAgEsIOACAS\nwg4AIBLCDgAgEsIOACASwg4AIBLCDgAgEsIOACASwg4AIBLCDgAgEsIOACASwg4AIBLCDgAg\nEsIOACASwg4AIBLCDgAgEsIOACASwg4AIBLCDgAgEsIOACASwg4AIBLCDgAgEsIOACASwg4A\nIBLCDgAgEsIOACASwg4AIBLCDgAgEsIOACASwg4AIBLCDgAgEsIOACASwg4AIBLCDgAgEsIO\nACASwg4AIBLCDgAgEsIOACASwg4AIBLCDgAgEsIOACASwg4AIBLCDgAgEsIOACASqeJ++EWP\nnnHsN5/quvLFH9z2ieFVIYQQcg/ecuk9D89/aVVy+x13P3L6UVtWJ9/VOgBAWShy2K3404rq\nEZ/6yrHjO1fG1lZ2XHjhjpkX3fqvqSd96QvD2396xSVnfLX9xsuOTxS+DgBQJoocdm88s3LY\nDnvsscf4tx/It8659dlxU+dM2XfLEMK4C8PB075182tTDxuZLmx909oBv08AAMVR5OfY/Xll\ny/BdhmXXrnz9jRX5LustjQ8vbM7uP2lUx5uZ4XvtPKTy8YcWFbo+oHcGAKCoivyI3R+b2nK/\nnffZi59ry+dTtRt/9LCvfPFTO4UQWlf/JYSwQ82b442vSf3y6cbWvQpb7/qxnnjiiVwu13G5\nvr5+5MiR/XjHBrdUKtV5oaLCC2gGu2Ry3bNF0+l0cSehrDjfSov9Ki39t1/FDLts6yuNieSY\njSZceNPs+uzK3//s6u9cNTOz9Q+P3G5YrmV1CKEh/earHxrSybaVbYWud/1wJ598cnNzc8fl\nyZMnz5o1qz/vXGmoq6sr9ggUoL6+vtgjUEacb6XFfpWW9dmvbDbbw9FiPlqTrBx9++23f3v6\nge+prcwMbZj4udM+NaL6gaufDiFUZGpCCMvacp1XXtKWTQ1JFbo+YPcFAKDoBlf6fOA91Q8s\nXxxCSNe8L4SHnlvbNrIy03Fowdr2+vH1ha53fec///nP8/l1T+TL5XJLly4doHs1+KTT6aFD\nh4YQli9f3vnjaQatTCYzZMiQEEI5n7QMPOdbabFfpWU992vEiBHdHSpm2K1YcMmM/3vmgksv\n3qSyIoQQ8tmHXlszbNdtQghVw/YZXXnZvY8s/tD+m4UQ2prmP7Gqdco+I+RVKqQAABZGSURB\nVKuGvbeg9a4fruuPHZubm5uamgbwvg4unYH7tssRmz59erFHIMybN6/YI1CAMvniEA37VVr6\nb7+K+aPYoWMPGbFm0annXPHE0wue/+ufbp57ysOr6447ZpsQQkikZ0zZ7vlrzn5g/oJXX3jq\n6llzakfvN3VUbcHrAABlo5iP2FWkGmZfcs51l9/43fNOb04NHTtux1PnnrvLkHWvExl3yHkn\ntsy9ac6spc2JrXaeOHvGsYl3tQ4AUCaK/By7zPDxx3/jguPf8Vgiud+0GftNW+91AIDy4HeY\nAQBEQtgBAERC2AEARELYAQBEQtgBAERC2AEARELYAQBEQtgBAERC2AEARELYAQBEQtgBAERC\n2AEARELYAQBEQtgBAERC2AEARELYAQBEQtgBAERC2AEARELYAQBEQtgBAERC2AEARELYAQBE\nQtgBAERC2AEARELYAQBEQtgBAERC2AEARELYAQBEQtgBAERC2AEARELYAQBEQtgBAERC2AEA\nRELYAQBEQtgBAERC2AEARELYAQBEQtgBAERC2AEARELYAQBEQtgBAERC2AEARELYAQBEQtgB\nAERC2AEARELYAQBEQtgBAERC2AEARELYAQBEQtgBAERC2AEARELYAQBEQtgBAERC2AEARELY\nAQBEQtgBAERC2AEARELYAQBEQtgBAERC2AEARELYAQBEQtgBAERC2AEARELYAQBEQtgBAERC\n2AEARELYAQBEQtgBAERC2AEARELYAQBEQtgBAERC2AEARELYAQBEQtgBAERC2AEARCJV7AGK\nI5lMDh8+vNhTFE0ikei4MHTo0OJOQlkp5390pch+lRb7VVrWZ79yuVwPR8s07HK53Jo1a4o9\nRdGkUqna2toQwpo1a3o+P2ADampqKvYIFMB+lRb7VVrWc7/q6+u7O1SmYZfP59va2oo9RfG1\nt7dns9liT0G58I+utNiv0mK/Skv/7Zfn2AEARELYAQBEQtgBAERC2AEARELYAQBEQtgBAERC\n2AEARELYAQBEQtgBAERC2AEARELYAQBEQtgBAERC2AEARELYAQBEQtgBAERC2AEARELYAQBE\nQtgBAERC2AEARELYAQBEQtgBAERC2AEARELYAQBEQtgBAERC2AEARELYAQBEIlXsAUrV9OnT\niz0CYd68ecUeAQAGEY/YAQBEQtgBAERC2AEARELYAQBEQtgBAERC2AEARELYAQBEQtgBAERC\n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"
     },
     "metadata": {
      "image/png": {
       "height": 420,
       "width": 420
      }
     },
     "output_type": "display_data"
    }
   ],
   "source": [
    "ggplot(data = diamonds) +\n",
    "  geom_bar(mapping = aes(x = cut))"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 3,
   "id": "0eb543f5",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-01-25T06:22:31.513718Z",
     "iopub.status.busy": "2023-01-25T06:22:31.511659Z",
     "iopub.status.idle": "2023-01-25T06:22:31.601321Z",
     "shell.execute_reply": "2023-01-25T06:22:31.567854Z"
    },
    "papermill": {
     "duration": 0.098122,
     "end_time": "2023-01-25T06:22:31.604408",
     "exception": false,
     "start_time": "2023-01-25T06:22:31.506286",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A tibble: 5 × 2</caption>\n",
       "<thead>\n",
       "\t<tr><th scope=col>cut</th><th scope=col>n</th></tr>\n",
       "\t<tr><th scope=col>&lt;ord&gt;</th><th scope=col>&lt;int&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><td>Fair     </td><td> 1610</td></tr>\n",
       "\t<tr><td>Good     </td><td> 4906</td></tr>\n",
       "\t<tr><td>Very Good</td><td>12082</td></tr>\n",
       "\t<tr><td>Premium  </td><td>13791</td></tr>\n",
       "\t<tr><td>Ideal    </td><td>21551</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A tibble: 5 × 2\n",
       "\\begin{tabular}{ll}\n",
       " cut & n\\\\\n",
       " <ord> & <int>\\\\\n",
       "\\hline\n",
       "\t Fair      &  1610\\\\\n",
       "\t Good      &  4906\\\\\n",
       "\t Very Good & 12082\\\\\n",
       "\t Premium   & 13791\\\\\n",
       "\t Ideal     & 21551\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A tibble: 5 × 2\n",
       "\n",
       "| cut &lt;ord&gt; | n &lt;int&gt; |\n",
       "|---|---|\n",
       "| Fair      |  1610 |\n",
       "| Good      |  4906 |\n",
       "| Very Good | 12082 |\n",
       "| Premium   | 13791 |\n",
       "| Ideal     | 21551 |\n",
       "\n"
      ],
      "text/plain": [
       "  cut       n    \n",
       "1 Fair       1610\n",
       "2 Good       4906\n",
       "3 Very Good 12082\n",
       "4 Premium   13791\n",
       "5 Ideal     21551"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "# how many observations occurred with each x value\n",
    "diamonds %>% \n",
    "  count(cut)\n",
    "#> # A tibble: 5 × 2\n",
    "#>   cut           n\n",
    "#>   <ord>     <int>\n",
    "#> 1 Fair       1610\n",
    "#> 2 Good       4906\n",
    "#> 3 Very Good 12082\n",
    "#> 4 Premium   13791\n",
    "#> 5 Ideal     21551"
   ]
  }
 ],
 "metadata": {
  "kernelspec": {
   "display_name": "R",
   "language": "R",
   "name": "ir"
  },
  "language_info": {
   "codemirror_mode": "r",
   "file_extension": ".r",
   "mimetype": "text/x-r-source",
   "name": "R",
   "pygments_lexer": "r",
   "version": "4.0.5"
  },
  "papermill": {
   "default_parameters": {},
   "duration": 6.098392,
   "end_time": "2023-01-25T06:22:31.730799",
   "environment_variables": {},
   "exception": null,
   "input_path": "__notebook__.ipynb",
   "output_path": "__notebook__.ipynb",
   "parameters": {},
   "start_time": "2023-01-25T06:22:25.632407",
   "version": "2.4.0"
  }
 },
 "nbformat": 4,
 "nbformat_minor": 5
}
