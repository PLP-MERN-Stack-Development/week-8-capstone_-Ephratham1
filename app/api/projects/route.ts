import { type NextRequest, NextResponse } from "next/server"

// Mock database - in production, use MongoDB
const projects = [
  {
    id: "1",
    name: "Website Redesign",
    description: "Complete overhaul of company website with modern design",
    status: "In Progress",
    priority: "High",
    startDate: "2024-01-01",
    dueDate: "2024-02-15",
    progress: 75,
    teamMembers: ["user1", "user2", "user3"],
    createdAt: new Date().toISOString(),
    updatedAt: new Date().toISOString(),
  },
  {
    id: "2",
    name: "Mobile App Development",
    description: "Native iOS and Android app for customer engagement",
    status: "In Progress",
    priority: "Medium",
    startDate: "2024-01-15",
    dueDate: "2024-03-01",
    progress: 45,
    teamMembers: ["user1", "user4"],
    createdAt: new Date().toISOString(),
    updatedAt: new Date().toISOString(),
  },
]

export async function GET(request: NextRequest) {
  try {
    const { searchParams } = new URL(request.url)
    const status = searchParams.get("status")
    const priority = searchParams.get("priority")

    let filteredProjects = projects

    if (status) {
      filteredProjects = filteredProjects.filter((p) => p.status === status)
    }

    if (priority) {
      filteredProjects = filteredProjects.filter((p) => p.priority === priority)
    }

    return NextResponse.json({
      projects: filteredProjects,
      total: filteredProjects.length,
    })
  } catch (error) {
    console.error("Get projects error:", error)
    return NextResponse.json({ message: "Internal server error" }, { status: 500 })
  }
}

export async function POST(request: NextRequest) {
  try {
    const { name, description, priority, dueDate, teamMembers } = await request.json()

    // Validation
    if (!name || !description) {
      return NextResponse.json({ message: "Name and description are required" }, { status: 400 })
    }

    // Create project
    const project = {
      id: Date.now().toString(),
      name,
      description,
      status: "Planning",
      priority: priority || "Medium",
      startDate: new Date().toISOString().split("T")[0],
      dueDate: dueDate || null,
      progress: 0,
      teamMembers: teamMembers || [],
      createdAt: new Date().toISOString(),
      updatedAt: new Date().toISOString(),
    }

    projects.push(project)

    return NextResponse.json(
      {
        message: "Project created successfully",
        project,
      },
      { status: 201 },
    )
  } catch (error) {
    console.error("Create project error:", error)
    return NextResponse.json({ message: "Internal server error" }, { status: 500 })
  }
}
