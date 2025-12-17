# 🔍 Salesforce Contact Search & Manager

A Lightning Web Component that provides advanced contact search and management capabilities with dynamic filtering, real-time search, and a modern UI.

## ✨ Features

- 🔎 **Real-time Search** - Search contacts by name, email, or phone
- 🎯 **Dynamic Filters** - Filter by Account, Title, Department
- 📱 **Responsive Design** - Works seamlessly on desktop and mobile
- ⚡ **Fast Performance** - Optimized SOQL queries
- 🎨 **Modern UI** - Built with Salesforce Lightning Design System

## 🛠️ Tech Stack

- **Lightning Web Components (LWC)**
- **Apex** - Backend controller with SOQL
- **Salesforce DX** - Modern development workflow
- **SLDS** - Salesforce Lightning Design System

## 📋 Prerequisites

- Salesforce Developer Org ([Sign up here](https://developer.salesforce.com/signup))
- Salesforce CLI installed ([Installation guide](https://developer.salesforce.com/tools/sfdxcli))
- VS Code with Salesforce Extensions ([Setup guide](https://developer.salesforce.com/tools/vscode))

## 🚀 Getting Started

### 1. Clone the Repository

```bash
git clone https://github.com/Luis-E-DevI/salesforce-contact-manager.git
cd salesforce-contact-manager
```

### 2. Authorize Your Org

```bash
sf org login web --set-default-dev-hub --alias myDevHub
```

### 3. Create a Scratch Org (Optional)

```bash
sf org create scratch --definition-file config/project-scratch-def.json --alias contactManager --set-default
```

Or deploy to your existing Developer Org: 

```bash
sf org login web --alias myDevOrg --set-default
```

### 4. Deploy the Code

```bash
sf project deploy start --source-path force-app
```

### 5. Assign Permission Set (if created)

```bash
sf org assign permset --name Contact_Manager_User
```

### 6. Open Your Org

```bash
sf org open
```

### 7. Add Component to a Page

- Go to Setup → Lightning App Builder
- Edit a record page or create a new one
- Drag the **Contact Search Manager** component onto the page
- Save and activate

## 📁 Project Structure

```
salesforce-contact-manager/
├── force-app/
│   └── main/
│       └── default/
│           ├── lwc/
│           │   └── contactSearchManager/
│           │       ├── contactSearchManager.js
│           │       ├── contactSearchManager.html
│           │       ├── contactSearchManager.css
│           │       └── contactSearchManager.js-meta.xml
│           └── classes/
│               ├── ContactController.cls
│               └── ContactController.cls-meta.xml
├── config/
│   └── project-scratch-def.json
├── sfdx-project.json
├── .gitignore
└── README.md
```

## 🎯 Component Features

### Search Functionality
- Search across Name, Email, and Phone fields
- Debounced input for performance
- Clear search button

### Filtering Options
- Filter by Account
- Filter by Title
- Filter by Department
- Combine multiple filters

### Contact Display
- Card-based layout
- Contact avatar/initials
- Key information at a glance
- Click to view full details

### Error Handling
- Loading spinners
- Error messages
- Empty state handling
- No results found state

## 🧪 Testing

Run Apex tests:

```bash
sf apex run test --test-level RunLocalTests --result-format human --code-coverage
```

## 📸 Screenshots

_Coming soon! Screenshots will be added after deployment._

## 🎓 What I Learned

- Building reusable Lightning Web Components
- Implementing dynamic SOQL queries in Apex
- Managing component state and data flow
- Creating responsive layouts with SLDS
- Best practices for error handling and user feedback

## 🔜 Future Enhancements

- [ ] Inline editing capabilities
- [ ] Create new contacts from the component
- [ ] Export contacts to CSV
- [ ] Email/Call quick actions
- [ ] Favorites/Recent contacts
- [ ] Advanced filtering with date ranges

## 📝 License

This project is open source and available under the [MIT License](LICENSE).

## 👤 Author

**Luis**
- GitHub: [@Luis-E-DevI](https://github.com/Luis-E-DevI)
- LinkedIn: [Add your LinkedIn]

## ⭐ Show Your Support

Give a ⭐️ if this project helped you learn Lightning Web Components!

---

Built with ❤️ using Salesforce Lightning Web Components
