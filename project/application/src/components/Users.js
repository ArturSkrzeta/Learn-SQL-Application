import React from 'react'

export const Users = ({users, deleteUser}) => {

    if (users.length === 0) return null

    const UserRow = (user) => {
      return(
            <tr key={user.id}>
              <td>{user.id}</td>
              <td>{user.firstname}</td>
              <td>{user.lastname}</td>
              <td>{user.email}</td>
              <td>{user.phonenumber}</td>
              <td><button onClick={() => deleteUser(user)}>Delete</button></td>
            </tr>
        )
    }

    const userTable = users.map((user) => {
    	if (user.firstname === "1"){
    		return null;
    	}else{
    		return UserRow(user)
    	}
    })

    return(
        <div className="table_container">
          <table className="fl-table">
            <thead>
            <tr>
                <th>User Id</th>
                <th>Firstname</th>
                <th>Lastname</th>
                <th>Email</th>
                <th>Phone Number</th>
                <th>Action</th>
            </tr>
            </thead>
            <tbody>
                {userTable}
            </tbody>
          </table>
        </div>
    )
}
